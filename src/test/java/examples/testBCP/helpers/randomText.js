function(min, max){
    var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var len = Math.floor(Math.random() * (max - min + 1)) + min;
    var result = '';
    for (var i = 0; i < len; i++) {
      result += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return result.trim();
}
