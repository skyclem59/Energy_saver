PROVIDERS = [
  {
    name: 'Nest',
    image: 'nest.png',

    type: 'Thermostat',
    

    link: "https://home.nest.com/login/oauth2?client_id=#{ENV['NEST_ID']}&redirect_uri=http://localhost:3000/nest/callback&state=EZAEREZAEZARZEREZZGSFGFSGSFGERZTAZ"

  },
  {
    name: 'Smappee',
    image: 'smappee.jpg',
    type: 'Smappee',
    link: '/auth/smappee'
  },
  {
    name: 'Philips HUE',
    image: 'hue.png',
    type: 'Lampes',
    link: '/auth/philips'
  }
]
