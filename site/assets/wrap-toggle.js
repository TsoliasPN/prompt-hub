(function () {
  const STORAGE_KEY = 'promptHub.wrapCode';

  function setWrap(enabled) {
    document.documentElement.classList.toggle('wrap-code-on', !!enabled);
    try { localStorage.setItem(STORAGE_KEY, enabled ? '1' : '0'); } catch (e) {}
    const btn = document.getElementById('wrap-toggle');
    if (btn) btn.dataset.state = enabled ? 'on' : 'off';
  }

  function getWrap() {
    try {
      const v = localStorage.getItem(STORAGE_KEY);
      // Default to ON when not set
      return v === null ? true : v === '1';
    } catch (e) { return true; }
  }

  function ensureButton() {
    const palette = document.querySelector('form.md-header__option[data-md-component="palette"]');
    const search = document.querySelector('div.md-search');
    const nav = document.querySelector('header.md-header nav.md-header__inner');
    const container = (search && search.parentElement) || (palette && palette.parentElement) || nav;
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

    // Prefer placing immediately before the search bar to keep site title area intact
    if (search && search.parentElement === container) {
      container.insertBefore(btn, search);
    } else if (palette && palette.parentElement === container) {
      container.insertBefore(btn, palette.nextSibling);
    } else {
      container.appendChild(btn);
    }

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
