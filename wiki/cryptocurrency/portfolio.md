# Shared portfolio

{% assign csv_file_id = "portfolio_shared" %}
{% assign csv_file_data = site.data.portfolio_shared %}

<table id="{{ csv_file_id }}">
  {% for row in csv_file_data %}
    {% if forloop.first %}
    <tr>
      {% for pair in row %}
        {% if pair[0] != 'ID' %}
          <th>{{ pair[0] }}</th>
        {% endif %}
      {% endfor %}
    </tr>
    {% endif %}

    {% assign row_id = row['ID'] %}
    <tr id="{{ row_id }}">
      {% for pair in row %}
        {% if pair[0] != 'ID' %}
          <td class="{{ pair[0] | slugify }}">
            {{ pair[1] }}
          </td>
        {% endif %}
      {% endfor %}
    </tr>
  {% endfor %}
</table>

<script async>

var table = document.querySelector("#{{ csv_file_id }}")
var table_rows = table.rows;

var coin_id_string = "";
for (var i = 1, row; row = table_rows[i]; i++) {
    coin_id_string += ',' + row.id;
}

var coingecko_url = `https://api.coingecko.com/api/v3/simple/price?ids=${coin_id_string}&vs_currencies=usd`;

fetch(coingecko_url)
.then((response) => {
    return response.json();
})
.then((prices) => {
    var total = 0;
    for (var i = 1, row; row = table_rows[i]; i++) {
        var coin_price = prices[row.id]['usd'];
        var coin_quantity = row.getElementsByClassName('quantity')[0].innerText;
        var coin_total = coin_price * coin_quantity;
        total += coin_total;

        row.getElementsByClassName('current-price')[0].innerText = '$' + coin_price;
        row.getElementsByClassName('total')[0].innerText = '$' + coin_total;
    }

    total_row = table.insertRow(-1);
    total_row.style.display = "none";

    total_row.innerHTML = table_rows[0].innerHTML;
    for (var i = 0, col; col = total_row.cells[i]; i++) col.innerText = "";
    total_row.cells[0].innerText = "Total";
    total_row.cells[total_row.cells.length - 1].innerText = '$' + total;
    total_row.style.display = "";
});

</script>

{% comment %}
<div id="dprice"></div>
<script>
    fetch('https://api.coingecko.com/api/v3/coins/mina-protocol?tickers=true&market_data=true&community_data=true&developer_data=true&sparkline=false')
    .then((response) => {
      return response.text();
    })
    .then((myContent) => {
        var market = JSON.parse(myContent);
        var info = market["market_data"]["current_price"]["usd"];
        document.getElementById('dprice').innerHTML = info;
    });
</script>
{% endcomment %}

Note: to edit this table, see the `_data/{{ csv_file_id}}.csv` file in the repository.
