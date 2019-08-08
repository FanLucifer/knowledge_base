import React from 'react'

class  HelloWorld extends React.Component {
  constructor(props) {
    super(props)
  }

  componentWillMount(){
    console.log("HelloWorld WillMount")
  }

  render() {

    return (
      <div>hello{this.props.name}</div>
    )
  }
}

export default HelloWorld
