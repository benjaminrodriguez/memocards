<?php

//var_dump($_SESSION);

// UNSET THE VAR FROM THE PREVIOUS GAME
if (!isset($_SESSION['deck']))
{
    foreach($_SESSION as $key => $value){
        if($key !== "id")
        unset($_SESSION[$key]);
    }
    
    $_POST['deck'] = 1;
    $_SESSION['deck'] = $_POST['deck'];
    require(dirname(__FILE__).'/../Views/affichage_debquest.php');
    if (isset($_SESSION['list']))
    {
        unset($_SESSION['list']);
    }
    if (isset($_SESSION['cpt']))
    {
        unset($_SESSION['cpt']);
    }
    if (isset($_SESSION['cptall']))
    {
        unset($_SESSION['cptall']);
    }
    if (isset($_SESSION['iddelaquestiondavant']))
    {
        unset($_SESSION['iddelaquestiondavant']);
    }

}
else
{
    // SET THE VAR USED LATER
    if (isset($_SESSION['list']))
    {
        $list = $_SESSION['list'];
    }
    else
    {
        $list = array();
    }

    if (isset($_GET['qcm'])) {
        $_SESSION['qcm'] = $_GET['qcm'];
    }
    if (isset($_SESSION['listend'])) 
    {
        $listend = $_SESSION['listend'];
    }
    else
    {
        $listend = array();
    }

    if(!isset($_SESSION['cpt'])) 
    {
        $_SESSION['cpt'] = 1;
    }

    // CPTALL = TOTAL OF CARDS IN THE DECK
    if(!isset($_SESSION['cptall']))
    {   
        $_SESSION['cptall'] = nb_card_SELECT($_SESSION['deck']);
        $_SESSION['cptall'] = intval($_SESSION['cptall'][0]['count']);
    }

    //var_dump($_SESSION['cptall']);

    //ACTION WITH THE ANSWER
    if (isset($_POST['answer']))
    {
        //echo $_SESSION['iddelaquestiondavant'];

        //SAVE THE ANSWERS FOR THE DISPLAY AT THE END
        $listend[0][] = $_POST['answer'];
        $listend[1][] = $_SESSION['iddelaquestiondavant'];
        //$listend[$_SESSION['iddelaquestiondavant']] = $_POST['answer'];
        
        //GET THE INFO ABOUT THE CARD
        $getquest = carte_recup_SELECT($_SESSION['iddelaquestiondavant']);
        $played_card = $getquest[0]['played_cards'];
        $level_card = $getquest[0]['level_cards'];
        $chain = $getquest[0]['chain'];

        //var_dump($getquest);

        //CHANGE THEM
        if ($_POST['answer'] === 'T')
        {
            $played_card++;
            $level_card++;
            $chain++;
        }
        else if ($_POST['answer'] === 'F')
        {
            $played_card++;
            $level_card--;
            $chain = 0;
        }
        if ($chain === 3)
        {
            if ($level_card < 3) {
                $level_card = 3;
            }
        }
        //UPDATE THEM
        carte_UPDATE($getquest[0]['id'], $played_card, $chain, $level_card);
        $_SESSION['listend'] = $listend;
    }

    //CHECK IF USER WANT TO QUIT
    if (isset($_POST['fin']))
    {
        $_SESSION['cpt'] = $_SESSION['cptall'] + 1;
    }

    //var_dump($_SESSION['cpt']);
    //var_dump($_SESSION['cptall']);

    //CHECK IF USER STILLS HAVE CARD TO PLAY
    if ($_SESSION['cpt'] <= intval($_SESSION['cptall']))
    {
        //CHANGE THE WAY TO SELECT A CARD
        $choice = rand(0, 100);

        if(count($list) === 0)
        {
            $liststr = "''";
        } 
        else 
        {
            $liststr = implode(",",$list);
        }

        //var_dump($liststr);

        //CARD OFTEN WRONG
        if ($choice < 35)
        {
           
            //require("./modeles/quest1.php");
            $questions = quest1_SELECT($_SESSION['deck'], $liststr);
        }
        //RANDOM CARD
        else
        {
            //require("./modeles/quest2.php");
            $questions = quest2_SELECT($_SESSION['deck'], $liststr);
        }
        //var_dump($questions);

        //SAVE THE ID OF THE CHOSEN QUESTION;
        $IDDELAQUESTION = $questions[0]['id'];
        $list[]= $IDDELAQUESTION;
        
        //ANSWERS OF THE CARD
        $ans = verso_recup_SELECT($IDDELAQUESTION);
        //var_dump($ans);
        //echo $IDDELAQUESTION;

        // QUESTION OF THE CARD
        $q = carte_quest_SELECT($IDDELAQUESTION);
        require(dirname(__FILE__).'/../Views/affichage_quest.php');


        $_SESSION['cpt']++;
        $_SESSION['list'] = $list;
        $_SESSION['iddelaquestiondavant'] = $IDDELAQUESTION;
    }

    //DISPLAY OF THE RESULTS
    else
    {
        if (isset($_SESSION['listend']))
        {
            //var_dump($listend);
            foreach ($_SESSION['listend'][0] as $key => $value)
            {
                echo "Question n° ". (intval($key)+1)."<br><br>";
                if ($value === "T")
                {
                    echo "Carte :" . $_SESSION['listend'][1][$key]."<br>";
                    $q = carte_quest_SELECT($_SESSION['listend'][1][$key]);
                    echo $q[0]['q'];
                    echo "<br> >>>>> Bonne!";
                }
                else
                {
                    echo "Carte :" .$_SESSION['listend'][1][$key]."<br>";
                    $q = carte_quest_SELECT($_SESSION['listend'][1][$key]);
                    echo $q[0]['q'];
                    echo "<br> >>>>> Fausse!";
                }
                echo "<br><br>";
            }
        }
        unset($_SESSION['deck']);
        unset($_SESSION['listend']);
        unset($_SESSION['liste']);
    }
}

?>