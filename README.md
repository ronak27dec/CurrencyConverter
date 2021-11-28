
#Currency Converter

This is a simple app which converts a given amount from one currency into another. I named the app as 'Currency Converter'. 

User is expected to give following inputs - amount, source currency & target currency. 

Source & Target currency are being fetched from file (local) synchronously which is being saved in the form of JSON. Reason I choose not to make this as dynamic is i presume that the currency symbols wont change and update in future. We can mark this as an improvement to fetch the currencies from an API.

I have used an API to convert an amount from source currency to destination currency. 
API: https://v1.nocodeapi.com/ronak/cx/WVNLyyxFoilWLWUf/rates/convert 
This API requires parameters - amount, source currency & target currency. 

No third party API is used in the app. Every components is native.

The code is flexible and extendable. SOLID is kept in mind while developing.

Architecture followed is MVVM. 
Why ? 
- provides weak coupling between view, view model & model by using data binding. Here, since the app is simple enough, we have used closure based binding. 
- provides greater testability. Wrote tests for a view model and able to up achieve 97% coverage.

There is always scope of improvements in any code written :). I think we can make error handling more better as little importance is given on edge cases. 
UI can be improved with intuitive animations. 
More unit tests can be written if time permits.

