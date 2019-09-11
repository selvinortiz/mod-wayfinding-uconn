const defaultState = {
  kiosk: null,
  theme: {},
  settings: {},
  isMobile: false,
  searchIsOpen: false,
  initialized: false
};

export default {
  state: { ...defaultState },
  mutations: {
    setInitialized: (state, { kiosk, theme }) => {
      state.kiosk = kiosk;
      state.theme = theme;
      state.isMobile = kiosk ? true : false;
      state.initialized = true;
    },
    setSearchIsOpen: (state, isOpen) => {
      state.searchIsOpen = isOpen
    }
  }
};
