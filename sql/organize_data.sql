SET FOREIGN_KEY_CHECKS=0;

USE `elecciones_2013`;

START TRANSACTION; 

INSERT INTO `estado`
SELECT `estado`,`ubicacion` FROM `elecciones_2013_codigos`
    WHERE `estado`    != '00' 
      AND `municipio`  = '00' 
      AND `parroquia`  = '00' 
      AND `centro`     = '000' 
      AND `mesa`       = '000';

INSERT INTO `municipio`
SELECT `estado`,`municipio`,`ubicacion` FROM `elecciones_2013_codigos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia`  = '00' 
      AND `centro`     = '000' 
      AND `mesa`       = '000';

INSERT INTO `parroquia`
SELECT `estado`,`municipio`,`parroquia`,`ubicacion` FROM `elecciones_2013_codigos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia` != '00' 
      AND `centro`     = '000' 
      AND `mesa`       = '000';

INSERT INTO `centro`
SELECT `estado`,`municipio`,`parroquia`,`centro`,`ubicacion` FROM `elecciones_2013_codigos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia` != '00' 
      AND `centro`    != '000' 
      AND `mesa`       = '000';

INSERT INTO `mesa`
SELECT `estado`,`municipio`,`parroquia`,`centro`,`mesa`,`ubicacion` FROM `elecciones_2013_codigos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia` != '00' 
      AND `centro`    != '000' 
      AND `mesa`      != '000';

INSERT INTO `candidato` (`nom_candidato`)
  SELECT DISTINCT `candidato` AS `nom_candidato`
    FROM `elecciones_2013_candidatos`
    ORDER BY nom_candidato;

INSERT INTO `partido` (nom_partido) 
  SELECT DISTINCT `partido` AS `nom_partido`
    FROM `elecciones_2013_partidos`
    ORDER BY nom_partido;

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'HENRIQUE CAPRILES RADONSKI' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'MESA DE LA UNIDAD DEMOCRATICA')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'EUSEBIO MENDEZ' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'NUEVA VISION PARA MI PAIS')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'MARIA BOLIVAR' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'PARTIDO DEMOCRATICO UNIDOS POR LA PAZ Y LA LIBERTAD')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'REINA SEQUERA' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'PODER LABORAL')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'JULIO MORA' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'UNIDAD DEMOCRATICA')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'PARTIDO SOCIALISTA UNIDO DE VENEZUELA')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'PARTIDO COMUNISTA DE VENEZUELA')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'TENDENCIAS UNIFICADAS PARA ALCANZAR EL MOV. DE ACCION REV. ORGANIZADA')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'POR LA DEMOCRACIA SOCIAL')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'NUEVO CAMINO REVOLUCIONARIO')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'REDES DE RESPUESTAS DE CAMBIOS COMUNITARIOS')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'MOVIMIENTO ELECTORAL DEL PUEBLO')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'UNIDAD POPULAR VENEZOLANA')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'ORGANIZACION RENOVADORA AUTENTICA')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'INDEPENDIENTES POR LA COMUNIDAD NACIONAL')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'PARTIDO REVOLUCIONARIO DEL TRABAJO')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'JUVENTUD UNIDA EN ACCION NACIONAL CON BIMBA')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'VTV')
  );

INSERT INTO `candidato_partido` (`id_candidato`,`id_partido`) VALUES 
  ((SELECT `id_candidato` 
      FROM `candidato` 
      WHERE `nom_candidato` = 'NICOLAS MADURO' ),
   (SELECT `id_partido` 
      FROM `partido` 
      WHERE `nom_partido` = 'CORRIENTES REVOLUCIONARIAS VENEZOLANAS')
  );

CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_data_candidatos` 
  SELECT `estado`,`municipio`,`parroquia`,`centro`,`mesa`,`id_candidato`,`votos`,`porcentaje` 
    FROM `elecciones_2013_candidatos` INNER JOIN `candidato` ON `nom_candidato` = `candidato`;

INSERT INTO `votos_candidatos_estado` 
SELECT `estado`,`id_candidato`,`votos`,`porcentaje` FROM `tmp_data_candidatos`
    WHERE `estado`    != '00' 
      AND `municipio`  = '00' 
      AND `parroquia`  = '00' 
      AND `centro`     = '000' 
      AND `mesa`       = '000';

INSERT INTO `votos_candidatos_municipio`
SELECT `estado`,`municipio`,`id_candidato`,`votos`,`porcentaje` FROM `tmp_data_candidatos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia`  = '00' 
      AND `centro`     = '000' 
      AND `mesa`       = '000';

INSERT INTO `votos_candidatos_parroquia` 
SELECT `estado`,`municipio`,`parroquia`,`id_candidato`,`votos`,`porcentaje` FROM `tmp_data_candidatos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia` != '00' 
      AND `centro`     = '000' 
      AND `mesa`       = '000';

INSERT INTO `votos_candidatos_centro` 
SELECT `estado`,`municipio`,`parroquia`,`centro`,`id_candidato`,`votos`,`porcentaje` FROM `tmp_data_candidatos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia` != '00' 
      AND `centro`    != '000' 
      AND `mesa`       = '000';

INSERT INTO `votos_candidatos_mesa` 
SELECT `estado`,`municipio`,`parroquia`,`centro`,`mesa`,`id_candidato`,`votos`,`porcentaje` FROM `tmp_data_candidatos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia` != '00' 
      AND `centro`    != '000' 
      AND `mesa`      != '000';

CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_data_partidos` 
  SELECT `estado`,`municipio`,`parroquia`,`centro`,`mesa`,`id_partido`,`votos`,`porcentaje` 
    FROM elecciones_2013_partidos INNER JOIN partido ON nom_partido = partido;

INSERT INTO `votos_partidos_estado` 
SELECT `estado`,`id_partido`,`votos`,`porcentaje` FROM `tmp_data_partidos`
    WHERE `estado`    != '00' 
      AND `municipio`  = '00' 
      AND `parroquia`  = '00' 
      AND `centro`     = '000' 
      AND `mesa`       = '000';

INSERT INTO `votos_partidos_municipio`
SELECT `estado`,`municipio`,`id_partido`,`votos`,`porcentaje` FROM `tmp_data_partidos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia`  = '00' 
      AND `centro`     = '000' 
      AND `mesa`       = '000';

INSERT INTO `votos_partidos_parroquia` 
SELECT `estado`,`municipio`,`parroquia`,`id_partido`,`votos`,`porcentaje` FROM `tmp_data_partidos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia` != '00' 
      AND `centro`     = '000' 
      AND `mesa`       = '000';

INSERT INTO `votos_partidos_centro` 
SELECT `estado`,`municipio`,`parroquia`,`centro`,`id_partido`,`votos`,`porcentaje` FROM `tmp_data_partidos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia` != '00' 
      AND `centro`    != '000' 
      AND `mesa`       = '000';

INSERT INTO `votos_partidos_mesa`
SELECT `estado`,`municipio`,`parroquia`,`centro`,`mesa`,`id_partido`,`votos`,`porcentaje` FROM `tmp_data_partidos`
    WHERE `estado`    != '00' 
      AND `municipio` != '00' 
      AND `parroquia` != '00' 
      AND `centro`    != '000' 
      AND `mesa`      != '000';

DROP TABLE `elecciones_2013_candidatos`;

DROP TABLE `elecciones_2013_codigos`;

DROP TABLE `elecciones_2013_partidos`;

COMMIT;

SET FOREIGN_KEY_CHECKS=1;
