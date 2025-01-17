<?php
//require("./Controllers/php/function_game.php");


if (isset($_POST['start'])) {
    $_SESSION['deck'] = $_GET['deck'];
}
if (!isset($_SESSION['deck']))
{
    $deckname = namedeck_SELECT($_GET['deck']);
    require("./Views/affichage_debquest.php");
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
    if (!isset($_SESSION['list']))
    {
        $_SESSION['list'] = array();
    }
    if (!isset($_SESSION['listend'])) 
    {
        $_SESSION['listend'] = array();
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

    if (isset($_POST['repuser'])) 
    {
        $repuser =str_replace(' ','',htmlspecialchars($_POST['repuser']));
        $repuser = strtolower($repuser);
        

        $repbdd = game2_rep_SELECT($_SESSION['iddelaquestiondavant']);
        //var_dump($repbdd);
        $repbdd = str_replace(' ','',htmlspecialchars($repbdd[0]["answer_cards"]));
        $repbdd = strtolower($repbdd);
        //var_dump($repbdd);
        //var_dump($repuser);
        if ($repuser === $repbdd) {
            $_POST['answer'] = 'T';
        }
        else {
            if (substr_count($repuser, $repbdd) > 0) 
            {
                $_POST['answer'] = 'T';
            } else {
                $_POST['answer'] = 'F';
            }
        }
        
        //SAVE THE ANSWERS FOR THE DISPLAY AT THE END

            //SAVE THE ANSWERS FOR THE DISPLAY AT THE END

        $_SESSION['listend'][0][] = $_POST['answer'];
        $_SESSION['listend'][1][] = $_SESSION['iddelaquestiondavant'];

        //$listend[$_SESSION['iddelaquestiondavant']] = $_POST['answer'];
        
        //GET THE INFO ABOUT THE CARD
        $getquest = carte_recup_SELECT($_SESSION['iddelaquestiondavant']);
        $played_card = $getquest[0]['played_cards'];
        $level_card = $getquest[0]['level_cards'];
        $chain = $getquest[0]['chain'];
        $win = $getquest[0]['nb_succes'];
        

        //var_dump($getquest);

        //CHANGE THEM
        if ($_POST['answer'] === 'T')
        {
            $played_card++;
            $level_card++;
            $chain++;
            $win++;
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
        carte_UPDATE($getquest[0]['id'], $played_card, $chain, $level_card,$win);
    }

    if (isset($_POST['fin']))
    {
        $_SESSION['cpt'] = $_SESSION['cptall'] + 1;
    }

    if ($_SESSION['cpt'] <= intval($_SESSION['cptall']))
    {
        //CHANGE THE WAY TO SELECT A CARD
        $choice = rand(0, 100);
        
        if(count($_SESSION['list']) === 0)
        {
            $liststr = "''";
        } 
        else 
        {
            $liststr = implode(",",$_SESSION['list']);
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
        $_SESSION['list'][]= $IDDELAQUESTION;
        
        //ANSWERS OF THE CARD
        // $ans = verso_recup_SELECT($IDDELAQUESTION);

        //echo $IDDELAQUESTION;

        // QUESTION OF THE CARD
        $q = carte_quest_SELECT($IDDELAQUESTION);

        //require(dirname(__FILE__).'./Views/affichage_quest.php');
        require("./Views/affichage_quest2.php");


        $_SESSION['cpt']++;
        //$_SESSION['list'] = $list;
        $_SESSION['iddelaquestiondavant'] = $IDDELAQUESTION;
    }
    else
    {
        if (isset($_SESSION['listend']))
        {
        //var_dump($_SESSION['listend']);

            
            if (isset($_SESSION['listend']['0'])) {
                $nbbonne = 0;
                $nbq = 0;
                foreach ($_SESSION['listend']['0'] as $key => $value) {
                    if ($value === "T") {
                        $nbbonne++;
                    }
                    $nbq++;
                }

                //var_dump($nbbonne);
                //var_dump($nbq);
        
                $pt = ($nbbonne / $nbq)*$nbbonne + 1;
                //update
                $passed = passed_SELECT($_SESSION['id'], $_SESSION['deck']);
                $nb = intval($passed['0']['number_game'])+ 1;
                $score = intval($passed['0']['score_user']) + $pt;
                passed_UPDATE($_SESSION['id'],$nb,$_SESSION['deck'],$score);
                
            }
            require("./Views/affichage_resultquest.php");
        }
        unset($_SESSION['deck']);
        unset($_SESSION['listend']);
        unset($_SESSION['list']);
        unset($_SESSION['cpt']);
        unset($_SESSION['cptall']);
        unset($_SESSION['iddelaquestiondavant']);
    }
}
require_once(dirname(__FILE__).'/../Views/template.php');

?>