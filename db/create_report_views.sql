create or replace view relatorio_respostas as
select ans.id, trk.name as capitulo, qts.name as questao, ans.json_value as resposta,
	   qts.answer_key as gabarito, pls.username as usuario, ans.created_at as data_criacao
  from answers as ans
       join players as pls on ans.player_id = pls.id
	   join questions as qts on ans.question_id = qts.id
       join tracks as trk on qts.track_id = trk.id
 