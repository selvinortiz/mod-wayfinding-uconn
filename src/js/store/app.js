const defaultState = {
  theme: {},
  kioskId: null,
  isMobile: false,
  initialized: false,
  searchIsOpen: false
};

export default {
  state: { ...defaultState },
  // actions: {
  //   INIT: context => {
  //     context.commit('setInitialized', true);
  //   }
  // },
  mutations: {
    setInitialized: (state, { isMobile, kioskId, theme }) => {
      state.theme    = JSON.parse(theme);
      state.kioskId  = kioskId;
      state.isMobile = isMobile;

      state.initialized = true;
    }
  }
};
