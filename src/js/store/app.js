const defaultState = {
  theme: {},
  kiosk: null,
  campus: null,
  settings: {
    logo: {},
    images: [],
  },
  isMobile: false,
  searchIsOpen: false,
  initialized: false
};

export default {
  state: { ...defaultState },
  mutations: {
    setInitialized: (state, { theme, kiosk, campus, settings }) => {
      state.theme = theme;
      state.kiosk = kiosk;
      state.campus = campus;
      state.settings = settings;
      state.isMobile = (kiosk && kiosk.id) ? false : true;
      state.initialized = true;
    },
    setSearchIsOpen: (state, isOpen) => {
      state.searchIsOpen = isOpen
    }
  }
};
