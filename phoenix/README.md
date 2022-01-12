# Phoenix

Ambiente contendo:
- Elixir 1.8.1
- Mix 1.8.1
- Phoenix 1.5.13

## Uso

```bash
docker-compose run phoenix bash
```

# Application Instructions

## Routes

- **/products**  | GET |
> The **/products** route returns a json with all the products registered in the database. If the database is empty it will return an empty json. It's possible to use parameters in the url for filtering the result, os the parameters correspond to the product information.

#### **The parameters:**
- **name, sku, description**
> All this three paramters have the same structure, both use some word to search for products that have this word in some part of their composition.

- **amount**
> This paramter needs a integer value. If used without the paramter c_amount, he will return the products has the same value.

- **price**
> This paramter needs a integer or float value. If used without the paramter c_price, he will return the products has the same value.

- **c_amount, c_price**
> This two paramters has the same structure, both use the "gt" and "lt" with values were "gt" its equals to greater than and "lt" its less than. In other words "gt" its for values greater than the base value, and the "lt" its for values lower than the base value. the c_amount is used with the paramter amount and the c_price with the paramter price.

**Note**
> If the paramters is not accompanied by your paramter relativo (price or amount), the filter will understand this as a inválid paramter.

Examples.
```
# parameters of a filter for products that have in their name the word coffee and a value less than 10.
/products?name=coffe&amount=10&c_amount=lt
```
**Note**
> If any non-existent or otherwise invalid parameters are passed, an empty list will be returned.

- **/products**  | POST |
> The route **/products** is responsible for creating and adding the product to the database. In the body of the request you must have all the values of the product.
> Values (None of the values can be empty or null). **The body of the request is a key with the name product and a json value containing the following information.**
> - sku | string |: This value is the product identifier. I chose to put it in string because the code pattern can vary from characters to numbers.
> - name | string |: This value is the name of the product.
> - description | string |: This value is the description of the product.
> - amount | integer |: This value refers to the amount of the product.
> - price | float |: This value refes to the price of the product.

Example:
```
{
	"product": {
		"sku": "SKU",
		"name": "Name",
		"description": "Description",
		"amount": 81,
		"price": 89
	}
}
```

- **/products** | PUT |
> The **/products/[id]** route is responsible for updating a registered product. This route requires product identification.
> The values of the request for update are the in the route **/products** | POST |. You can put only the values you want to update.

- **/products/[id]** | DELETE |
> The **/products/[id]** route is responsible for deleting a registred product. This route requires product identification.

- **/products/[id]** | GET |
> The **/products/[id]** route is responsible for showing a registred product. This route requires product identification.
