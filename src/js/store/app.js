const defaultState = {
  theme: {
    bg: '#fff',
    text: '#333',
    header: {
      logo: {},
      clock: {
        text: '#999'
      }
    },
    main: {},
    footer: {
      nav: {
        item: {
          bg: '#fff',
          text: '#3daefc',
          active: {
            bg: 'transparent',
            text: 'blue'
          }
        }
      }
    }
  },
  initialized: false
};

export default {
  state: { ...defaultState },
  actions: {
    INIT: context => {
      context.commit('setInitialized', true);
    }
  },
  mutations: {
    setInitialized: (state, initialized = true) => {
      state.initialized = initialized;
    }
  }
};
