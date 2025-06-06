function validateArticleDates(articles, TimeValidator) {
  for (var i = 0; i < articles.length; i++) {
    var fecha = articles[i].createdAt;
    var esValida = TimeValidator.fn(fecha);

    if (!esValida) {
      karate.fail('Invalid createdAt date at index ' + i + ': ' + fecha);
    } else {
      karate.log('The date is valid at index ' + i + ': ' + fecha);
    }
  }
}