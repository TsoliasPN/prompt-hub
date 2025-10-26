(function () {
  const STORAGE_KEY = 'promptHub.wrapCode';

  function setWrap(enabled) {
    document.documentElement.classList.toggle('wrap-code-on', !!enabled);
    try { localStorage.setItem(STORAGE_KEY, enabled ? '1' : '0'); } catch (e) {}
    const btn = document.getElementById('wrap-toggle');
    if (btn) btn.dataset.state = enabled ? 'on' : 'off';
  }

  function getWrap() {
    try { return localStorage.getItem(STORAGE_KEY) === '1'; } catch (e) { return false; }
  }

  function ensureButton() {
    const container = document.querySelector('.md-header__options') || document.querySelector('.md-header__title');
    if (!container) return;
    if (document.getElementById('wrap-toggle')) return;

    const btn = document.createElement('button');
    btn.id = 'wrap-toggle';
    btn.type = 'button';
    btn.className = 'md-header__button md-icon wrap-toggle-button';
    btn.title = 'Toggle code wrap';
    btn.setAttribute('aria-label', 'Toggle code wrap');

    const icon = document.createElement('span');
    icon.className = 'wrap-icon';
    btn.appendChild(icon);

    const label = document.createElement('span');
    label.className = 'wrap-label';
    label.textContent = 'Wrap';
    btn.appendChild(label);

    btn.addEventListener('click', function () {
      const newState = !document.documentElement.classList.contains('wrap-code-on');
      setWrap(newState);
    });

    // Place before the first option for visibility
    container.insertBefore(btn, container.firstChild || null);

    // Initialize state
    setWrap(getWrap());
  }

  // Initial run
  if (document.readyState !== 'loading') {
    ensureButton();
    setWrap(getWrap());
  } else {
    document.addEventListener('DOMContentLoaded', function () {
      ensureButton();
      setWrap(getWrap());
    });
  }

  // Re-run on MkDocs Material page change (instant loading)
  if (window.document$) {
    window.document$.subscribe(function () {
      ensureButton();
      setWrap(getWrap());
    });
  }
})();
