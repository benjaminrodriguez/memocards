<form action='' method='POST'>
    <button class="btn btn-lg btn-primary btn-block" name="choix_forum" value="creer_sujet">Créer un sujet</button>
</form>

<?php
        if (isset($_POST['choix_forum']) && $_POST['choix_forum'] === 'creer_sujet')
        {
?>
            <form action='' method='POST'>

                <input type='text' name='title' placeholder="Titre" required><br>

                <textarea name='content' rows="4" cols="50" placeholder="Describe yourself here" required> </textarea><br>

                <input type="hidden" name="choix_forum" value="creer_sujet" >

                <button class="btn btn-lg btn-primary" type="submit">Créer sujet</button>
            </form>
<?php
        }
?>