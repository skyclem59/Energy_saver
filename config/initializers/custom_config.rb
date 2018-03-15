PROVIDERS = [
  {
    name: 'Nest',
    image: 'nest.png',
    link: "https://home.nest.com/login/oauth2?client_id=#{ENV['NEST_ID']}&redirect_uri=https://energy-saver-skyclem59.herokuapp.com/nest/callback&state=EZAEREZAEZARZEREZZGSFGFSGSFGERZTAZ"
  },
  {
    name: 'Smappee',
    image: 'smappee.jpg',
    link: '/auth/smappee'
  },
  {
    name: 'Philips HUE',
    image: 'hue.png',
    link: '/auth/philips'
  }
]
