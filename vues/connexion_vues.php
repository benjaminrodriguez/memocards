<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../img/logo.png">
    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./css/formConnexion.css" rel="stylesheet">
  </head>

  <body class="text-center">
      <div class="background">
        <form class="form-signin"action="" name="connexion" method="POST"> <br>
            <img class="mb-4" src="./vues/img/logo.png" alt="" width="100" height="100">
            <h1 class="h3 mb-3 font-weight-normal">Bienvenue sur MemoCards</h1><br>
            <input type="text" name="username" id="inputEmail" class="form-control" placeholder="Username" required autofocus>
            <label for="inputPassword" class="sr-only"></label><br>
            <input type="password" value="" name="password"required id="inputPassword" class="form-control" placeholder="Password" required>
            <!--<div class="checkbox mb-3">Statut
            <select name="statut"required>
              <option value="eleve">Eleve</option>
              <option value="prof">Prof</option>
          </select>-->
      </div>
          <input type="submit" class="btn btn-lg btn-primary btn-block" value="Se connecter"></button>
          </form><br><br>
          <form action="index.php?page=inscription" method="POST">
            <button type="submit" class="btn btn-lg btn-primary btn-block" id="inscription" name="inscription" value="inscription"><h3>Inscription</h3></button>
          </form>
          <p class="mt-5 mb-3 text-muted">&copy; MemoCards</p>
        
    </div>
  </body>
</html>
