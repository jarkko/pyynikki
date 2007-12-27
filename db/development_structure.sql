CREATE TABLE `events` (
  `id` int(11) NOT NULL auto_increment,
  `event_date` date default NULL,
  `temperature` int(11) default NULL,
  `weather` varchar(255) default NULL,
  `story` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_events_on_event_date` (`event_date`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;

CREATE TABLE `runners` (
  `id` int(11) NOT NULL auto_increment,
  `birth_year` int(11) default NULL,
  `first_name` varchar(255) default NULL,
  `last_name` varchar(255) default NULL,
  `sex` varchar(255) default NULL,
  `outsider` tinyint(1) default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8;

CREATE TABLE `runs` (
  `id` int(11) NOT NULL auto_increment,
  `runner_id` int(11) default NULL,
  `event_id` int(11) default NULL,
  `time3600` int(11) default NULL,
  `time7600` int(11) default NULL,
  `time11200` int(11) default NULL,
  `time15200` int(11) default NULL,
  `outsider` tinyint(1) default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `age_class` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_runs_on_runner_id` (`runner_id`),
  KEY `index_runs_on_event_id` (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8701 DEFAULT CHARSET=utf8;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `schema_info` (version) VALUES (4)