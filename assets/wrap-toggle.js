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
    const container = document.querySelector('.md-header__options');
    if (!container) return;
    if (document.getElementById('wrap-toggle')) return;

    const btn = document.createElement('button');
    btn.id = 'wrap-toggle';
    btn.type = 'button';
    btn.className = 'md-header__button md-icon';
    btn.title = 'Toggle code wrap';
    btn.setAttribute('aria-label', 'Toggle code wrap');

    const span = document.createElement('span');
    span.className = 'wrap-icon';
    btn.appendChild(span);

    btn.addEventListener('click', function () {
      const newState = !document.documentElement.classList.contains('wrap-code-on');
      setWrap(newState);
    });

    // Place before the color palette toggle for visibility
    container.insertBefore(btn, container.firstChild);

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

