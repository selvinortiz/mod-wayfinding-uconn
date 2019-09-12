const defaultState = {
  theme: {},
  kiosk: null,
  campus: null,
  settings: {},
  isMobile: false,
  searchIsOpen: false,
  initialized: false
};

export default {
  state: { ...defaultState },
  mutations: {
    setInitialized: (state, { theme, campus, kiosk }) => {
      state.theme = theme;
      state.kiosk = kiosk;
      state.campus = campus;
      state.isMobile = kiosk ? true : false;
      state.initialized = true;
    },
    setSearchIsOpen: (state, isOpen) => {
      state.searchIsOpen = isOpen
    }
  }
};
