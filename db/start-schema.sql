#
# SQL Export
# Created by Querious (201067)
# Created: August 27, 2019 at 11:11:30 PM CDT
# Encoding: Unicode (UTF-8)
#


SET @PREVIOUS_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;


DROP TABLE IF EXISTS `mod_widgets`;
DROP TABLE IF EXISTS `mod_volumefolders`;
DROP TABLE IF EXISTS `mod_volumes`;
DROP TABLE IF EXISTS `mod_userpreferences`;
DROP TABLE IF EXISTS `mod_userpermissions_users`;
DROP TABLE IF EXISTS `mod_users`;
DROP TABLE IF EXISTS `mod_userpermissions_usergroups`;
DROP TABLE IF EXISTS `mod_userpermissions`;
DROP TABLE IF EXISTS `mod_usergroups_users`;
DROP TABLE IF EXISTS `mod_usergroups`;
DROP TABLE IF EXISTS `mod_tokens`;
DROP TABLE IF EXISTS `mod_templatecachequeries`;
DROP TABLE IF EXISTS `mod_templatecacheelements`;
DROP TABLE IF EXISTS `mod_templatecaches`;
DROP TABLE IF EXISTS `mod_tags`;
DROP TABLE IF EXISTS `mod_taggroups`;
DROP TABLE IF EXISTS `mod_systemmessages`;
DROP TABLE IF EXISTS `mod_structureelements`;
DROP TABLE IF EXISTS `mod_structures`;
DROP TABLE IF EXISTS `mod_sites`;
DROP TABLE IF EXISTS `mod_sitegroups`;
DROP TABLE IF EXISTS `mod_shunnedmessages`;
DROP TABLE IF EXISTS `mod_sessions`;
DROP TABLE IF EXISTS `mod_sequences`;
DROP TABLE IF EXISTS `mod_sections_sites`;
DROP TABLE IF EXISTS `mod_sections`;
DROP TABLE IF EXISTS `mod_searchindex`;
DROP TABLE IF EXISTS `mod_revisions`;
DROP TABLE IF EXISTS `mod_resourcepaths`;
DROP TABLE IF EXISTS `mod_relations`;
DROP TABLE IF EXISTS `mod_queue`;
DROP TABLE IF EXISTS `mod_migrations`;
DROP TABLE IF EXISTS `mod_plugins`;
DROP TABLE IF EXISTS `mod_matrixcontent_personroles`;
DROP TABLE IF EXISTS `mod_matrixblocks`;
DROP TABLE IF EXISTS `mod_matrixblocktypes`;
DROP TABLE IF EXISTS `mod_info`;
DROP TABLE IF EXISTS `mod_gqlschemas`;
DROP TABLE IF EXISTS `mod_globalsets`;
DROP TABLE IF EXISTS `mod_fieldlayoutfields`;
DROP TABLE IF EXISTS `mod_fields`;
DROP TABLE IF EXISTS `mod_fieldlayouttabs`;
DROP TABLE IF EXISTS `mod_fieldgroups`;
DROP TABLE IF EXISTS `mod_entrytypes`;
DROP TABLE IF EXISTS `mod_fieldlayouts`;
DROP TABLE IF EXISTS `mod_entries`;
DROP TABLE IF EXISTS `mod_elements_sites`;
DROP TABLE IF EXISTS `mod_elements`;
DROP TABLE IF EXISTS `mod_elementindexsettings`;
DROP TABLE IF EXISTS `mod_drafts`;
DROP TABLE IF EXISTS `mod_deprecationerrors`;
DROP TABLE IF EXISTS `mod_craftidtokens`;
DROP TABLE IF EXISTS `mod_content`;
DROP TABLE IF EXISTS `mod_categorygroups_sites`;
DROP TABLE IF EXISTS `mod_categories`;
DROP TABLE IF EXISTS `mod_categorygroups`;
DROP TABLE IF EXISTS `mod_assettransforms`;
DROP TABLE IF EXISTS `mod_assettransformindex`;
DROP TABLE IF EXISTS `mod_assets`;
DROP TABLE IF EXISTS `mod_assetindexdata`;


CREATE TABLE `mod_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `mod_assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `mod_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `mod_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `mod_assets_folderId_idx` (`folderId`),
  KEY `mod_assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `mod_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `mod_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `mod_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `mod_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_categorygroups_name_idx` (`name`),
  KEY `mod_categorygroups_handle_idx` (`handle`),
  KEY `mod_categorygroups_structureId_idx` (`structureId`),
  KEY `mod_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `mod_categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `mod_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `mod_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `mod_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `mod_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_categories_groupId_idx` (`groupId`),
  KEY `mod_categories_parentId_fk` (`parentId`),
  CONSTRAINT `mod_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `mod_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `mod_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `mod_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `mod_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `mod_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `mod_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_campusKey` text,
  `field_campusName` text,
  `field_campusDescription` text,
  `field_buildingKey` text,
  `field_buildingName` text,
  `field_buildingDescription` text,
  `field_buildingAddress` text,
  `field_buildingCity` text,
  `field_buildingState` text,
  `field_buildingZipcode` text,
  `field_floorKey` text,
  `field_floorNumber` text,
  `field_personKey` text,
  `field_personFirstName` text,
  `field_personLastName` text,
  `field_personDescription` text,
  `field_personEmail` varchar(255) DEFAULT NULL,
  `field_personPhone` text,
  `field_roomKey` text,
  `field_placeMarker` varchar(255) DEFAULT NULL,
  `field_roomDescription` text,
  `field_roomNumber` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `mod_content_siteId_idx` (`siteId`),
  KEY `mod_content_title_idx` (`title`),
  CONSTRAINT `mod_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `mod_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `mod_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `mod_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `mod_drafts_creatorId_fk` (`creatorId`),
  KEY `mod_drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `mod_drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `mod_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `mod_drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_elements_dateDeleted_idx` (`dateDeleted`),
  KEY `mod_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `mod_elements_type_idx` (`type`),
  KEY `mod_elements_enabled_idx` (`enabled`),
  KEY `mod_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `mod_elements_draftId_fk` (`draftId`),
  KEY `mod_elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `mod_elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `mod_drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `mod_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `mod_elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `mod_revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `mod_elements_sites_siteId_idx` (`siteId`),
  KEY `mod_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `mod_elements_sites_enabled_idx` (`enabled`),
  KEY `mod_elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `mod_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `mod_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_entries_postDate_idx` (`postDate`),
  KEY `mod_entries_expiryDate_idx` (`expiryDate`),
  KEY `mod_entries_authorId_idx` (`authorId`),
  KEY `mod_entries_sectionId_idx` (`sectionId`),
  KEY `mod_entries_typeId_idx` (`typeId`),
  KEY `mod_entries_parentId_fk` (`parentId`),
  CONSTRAINT `mod_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `mod_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `mod_entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `mod_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `mod_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `mod_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `mod_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `mod_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `mod_entrytypes_sectionId_idx` (`sectionId`),
  KEY `mod_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `mod_entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `mod_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `mod_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `mod_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `mod_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `mod_fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `mod_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `mod_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `mod_fields_groupId_idx` (`groupId`),
  KEY `mod_fields_context_idx` (`context`),
  CONSTRAINT `mod_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `mod_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `mod_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `mod_fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `mod_fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `mod_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `mod_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `mod_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `mod_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_globalsets_name_idx` (`name`),
  KEY `mod_globalsets_handle_idx` (`handle`),
  KEY `mod_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `mod_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `mod_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `mod_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `scope` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_gqlschemas_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `mod_gqlschemas_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `mod_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `mod_matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `mod_matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `mod_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `mod_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `mod_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `mod_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `mod_matrixblocks_typeId_idx` (`typeId`),
  KEY `mod_matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `mod_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `mod_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `mod_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_matrixcontent_personroles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_role_roleTitle` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_matrixcontent_personroles_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `mod_matrixcontent_personroles_siteId_fk` (`siteId`),
  CONSTRAINT `mod_matrixcontent_personroles_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_matrixcontent_personroles_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `mod_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_migrations_pluginId_idx` (`pluginId`),
  KEY `mod_migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `mod_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `mod_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `mod_queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `mod_queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `mod_relations_sourceId_idx` (`sourceId`),
  KEY `mod_relations_targetId_idx` (`targetId`),
  KEY `mod_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `mod_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `mod_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `mod_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mod_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `mod_revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `mod_revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `mod_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `mod_revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `mod_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `mod_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_sections_handle_idx` (`handle`),
  KEY `mod_sections_name_idx` (`name`),
  KEY `mod_sections_structureId_idx` (`structureId`),
  KEY `mod_sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `mod_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `mod_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `mod_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `mod_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `mod_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `mod_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_sessions_uid_idx` (`uid`),
  KEY `mod_sessions_token_idx` (`token`),
  KEY `mod_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `mod_sessions_userId_idx` (`userId`),
  CONSTRAINT `mod_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `mod_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `mod_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `mod_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `mod_sites_handle_idx` (`handle`),
  KEY `mod_sites_sortOrder_idx` (`sortOrder`),
  KEY `mod_sites_groupId_fk` (`groupId`),
  CONSTRAINT `mod_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `mod_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `mod_structureelements_root_idx` (`root`),
  KEY `mod_structureelements_lft_idx` (`lft`),
  KEY `mod_structureelements_rgt_idx` (`rgt`),
  KEY `mod_structureelements_level_idx` (`level`),
  KEY `mod_structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `mod_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `mod_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `mod_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_taggroups_name_idx` (`name`),
  KEY `mod_taggroups_handle_idx` (`handle`),
  KEY `mod_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `mod_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `mod_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `mod_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_tags_groupId_idx` (`groupId`),
  CONSTRAINT `mod_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `mod_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mod_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `mod_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `mod_templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `mod_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `mod_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `mod_templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `mod_templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `mod_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `mod_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mod_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `mod_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `mod_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `mod_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_tokens_token_unq_idx` (`token`),
  KEY `mod_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `mod_usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `mod_usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `mod_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `mod_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `mod_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `mod_userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `mod_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `mod_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `mod_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_users_uid_idx` (`uid`),
  KEY `mod_users_verificationCode_idx` (`verificationCode`),
  KEY `mod_users_email_idx` (`email`),
  KEY `mod_users_username_idx` (`username`),
  KEY `mod_users_photoId_fk` (`photoId`),
  CONSTRAINT `mod_users_id_fk` FOREIGN KEY (`id`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `mod_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `mod_userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `mod_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `mod_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `mod_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `mod_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `mod_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_volumes_name_idx` (`name`),
  KEY `mod_volumes_handle_idx` (`handle`),
  KEY `mod_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `mod_volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `mod_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `mod_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `mod_volumefolders_parentId_idx` (`parentId`),
  KEY `mod_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `mod_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `mod_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `mod_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mod_widgets_userId_idx` (`userId`),
  CONSTRAINT `mod_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `mod_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;




SET FOREIGN_KEY_CHECKS = @PREVIOUS_FOREIGN_KEY_CHECKS;


SET @PREVIOUS_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;


LOCK TABLES `mod_assetindexdata` WRITE;
ALTER TABLE `mod_assetindexdata` DISABLE KEYS;
ALTER TABLE `mod_assetindexdata` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_assets` WRITE;
ALTER TABLE `mod_assets` DISABLE KEYS;
ALTER TABLE `mod_assets` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_assettransformindex` WRITE;
ALTER TABLE `mod_assettransformindex` DISABLE KEYS;
ALTER TABLE `mod_assettransformindex` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_assettransforms` WRITE;
ALTER TABLE `mod_assettransforms` DISABLE KEYS;
ALTER TABLE `mod_assettransforms` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_categorygroups` WRITE;
ALTER TABLE `mod_categorygroups` DISABLE KEYS;
REPLACE INTO `mod_categorygroups` (`id`, `structureId`, `fieldLayoutId`, `name`, `handle`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,3,NULL,'Departments','departments','2019-08-28 03:08:45','2019-08-28 03:08:45',NULL,'343f1098-6cf9-4957-8533-ae04e7eb2a7a');
ALTER TABLE `mod_categorygroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_categories` WRITE;
ALTER TABLE `mod_categories` DISABLE KEYS;
ALTER TABLE `mod_categories` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_categorygroups_sites` WRITE;
ALTER TABLE `mod_categorygroups_sites` DISABLE KEYS;
REPLACE INTO `mod_categorygroups_sites` (`id`, `groupId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,1,'departments/{slug}','','2019-08-28 03:08:45','2019-08-28 03:09:39','4147ce98-b439-4ccd-b512-b0b219c6f9d5');
ALTER TABLE `mod_categorygroups_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_content` WRITE;
ALTER TABLE `mod_content` DISABLE KEYS;
REPLACE INTO `mod_content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_campusKey`, `field_campusName`, `field_campusDescription`, `field_buildingKey`, `field_buildingName`, `field_buildingDescription`, `field_buildingAddress`, `field_buildingCity`, `field_buildingState`, `field_buildingZipcode`, `field_floorKey`, `field_floorNumber`, `field_personKey`, `field_personFirstName`, `field_personLastName`, `field_personDescription`, `field_personEmail`, `field_personPhone`, `field_roomKey`, `field_placeMarker`, `field_roomDescription`, `field_roomNumber`) VALUES 
	(1,1,1,NULL,'2019-08-28 02:21:49','2019-08-28 02:21:49','1c63f9b5-b21d-476b-bd73-76ec29844ac4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,2,1,'Building - ','2019-08-28 03:09:54','2019-08-28 03:14:01','5c93db15-05d5-452e-a1fb-138943cfa87e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{"x":0,"xr":0,"y":0,"yr":0,"width":0,"height":0}',NULL,NULL);
ALTER TABLE `mod_content` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_craftidtokens` WRITE;
ALTER TABLE `mod_craftidtokens` DISABLE KEYS;
ALTER TABLE `mod_craftidtokens` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_deprecationerrors` WRITE;
ALTER TABLE `mod_deprecationerrors` DISABLE KEYS;
ALTER TABLE `mod_deprecationerrors` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_drafts` WRITE;
ALTER TABLE `mod_drafts` DISABLE KEYS;
REPLACE INTO `mod_drafts` (`id`, `sourceId`, `creatorId`, `name`, `notes`) VALUES 
	(1,NULL,1,'First draft','');
ALTER TABLE `mod_drafts` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_elementindexsettings` WRITE;
ALTER TABLE `mod_elementindexsettings` DISABLE KEYS;
REPLACE INTO `mod_elementindexsettings` (`id`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,'craft\\elements\\Entry','{"sources":{"section:2c0c1a7e-f890-4904-a132-cd347cc17da7":{"tableAttributes":{"1":"field:7","2":"field:2","3":"field:14","4":"field:15","5":"field:28","6":"field:31"}},"section:b796c1d1-b641-44ea-8128-02bc18f65fcc":{"tableAttributes":{"1":"field:22","2":"field:23","3":"field:24"}}}}','2019-08-28 04:10:45','2019-08-28 04:10:45','2290d65f-a11f-448e-8cd7-35cacfd4588e');
ALTER TABLE `mod_elementindexsettings` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_elements` WRITE;
ALTER TABLE `mod_elements` DISABLE KEYS;
REPLACE INTO `mod_elements` (`id`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2019-08-28 02:21:48','2019-08-28 02:21:48',NULL,'0b8caecd-3395-4ee0-95ab-cfa1ab8b4267'),
	(2,1,NULL,4,'craft\\elements\\Entry',1,0,'2019-08-28 03:09:53','2019-08-28 03:14:01',NULL,'16e7521d-ea8f-444f-99df-27e6575161c2');
ALTER TABLE `mod_elements` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_elements_sites` WRITE;
ALTER TABLE `mod_elements_sites` DISABLE KEYS;
REPLACE INTO `mod_elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,NULL,NULL,1,'2019-08-28 02:21:49','2019-08-28 02:21:49','c441353b-7d29-44a4-a6f1-7e920c9082eb'),
	(2,2,1,'__temp_jJxU2OGT13D10DwTNW4zi2KWzzyv69JxE9Q5',NULL,1,'2019-08-28 03:09:54','2019-08-28 03:09:54','e74550a7-b9f9-4386-98ca-adfe2a673f87');
ALTER TABLE `mod_elements_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_entries` WRITE;
ALTER TABLE `mod_entries` DISABLE KEYS;
REPLACE INTO `mod_entries` (`id`, `sectionId`, `parentId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `deletedWithEntryType`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(2,2,NULL,5,1,'2019-08-28 03:09:00',NULL,NULL,'2019-08-28 03:09:55','2019-08-28 03:14:01','8127daab-9baa-4a24-acfb-9305f404af82');
ALTER TABLE `mod_entries` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldlayouts` WRITE;
ALTER TABLE `mod_fieldlayouts` DISABLE KEYS;
REPLACE INTO `mod_fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,'craft\\elements\\MatrixBlock','2019-08-28 03:09:25','2019-08-28 03:09:25',NULL,'814be701-eac9-4e27-838d-2f4b23a3308f'),
	(2,'craft\\elements\\Entry','2019-08-28 03:09:35','2019-08-28 03:09:35',NULL,'a100f5ff-998d-47a7-8a5e-d0170cb56cf6'),
	(3,'craft\\elements\\Entry','2019-08-28 03:09:36','2019-08-28 03:09:36',NULL,'9c28951f-89c6-4e9d-a77b-073ffabd4a5b'),
	(4,'craft\\elements\\Entry','2019-08-28 03:09:37','2019-08-28 03:09:37',NULL,'5cfb5bd6-349f-40b8-896f-234c457c46fe'),
	(5,'craft\\elements\\Entry','2019-08-28 03:09:37','2019-08-28 03:09:37',NULL,'36786489-8f02-4c52-b9af-03c6508d969e'),
	(6,'craft\\elements\\Entry','2019-08-28 03:09:37','2019-08-28 03:09:37',NULL,'c16b2877-1a8f-44ff-8bda-2a36ba707185');
ALTER TABLE `mod_fieldlayouts` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_entrytypes` WRITE;
ALTER TABLE `mod_entrytypes` DISABLE KEYS;
REPLACE INTO `mod_entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,1,NULL,'People','people',1,'Title',NULL,1,'2019-08-28 03:08:45','2019-08-28 03:08:45','2019-08-28 03:09:39','a1d50f39-cb7f-47ca-95c0-e3592fb0e884'),
	(2,2,NULL,'Places','places',1,'Title',NULL,1,'2019-08-28 03:08:45','2019-08-28 03:08:45','2019-08-28 03:09:39','9b40dc30-0b06-43e8-8efd-1087a36dd583'),
	(3,1,2,'Person','person',0,'Title','{personFirstName} {personLastName}',2,'2019-08-28 03:09:36','2019-08-28 03:09:36',NULL,'c3a36f21-5c6b-42e4-b6ea-8e8b7e1204a4'),
	(4,2,3,'Campus','campus',0,'Title','Campus - {campusName}',2,'2019-08-28 03:09:36','2019-08-28 03:09:36',NULL,'093dfa29-a3d3-49b0-a677-f37bf3a9a1c4'),
	(5,2,4,'Building','building',0,'Title','Building - {buildingName}',3,'2019-08-28 03:09:37','2019-08-28 03:09:37',NULL,'c814d1a0-895d-4407-8635-94e0afc1ea2b'),
	(6,2,5,'Floor','floor',0,'Title','Floor {floorNumber}',4,'2019-08-28 03:09:37','2019-08-28 03:09:37',NULL,'08f47a8f-1a6c-46e6-8bf6-1f056246b083'),
	(7,2,6,'Room','room',0,'Title','Room {roomNumber}',5,'2019-08-28 03:09:37','2019-08-28 03:09:37',NULL,'b1e551b2-4335-4c4e-80e3-25359e851bc0');
ALTER TABLE `mod_entrytypes` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldgroups` WRITE;
ALTER TABLE `mod_fieldgroups` DISABLE KEYS;
REPLACE INTO `mod_fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,'Common','2019-08-28 02:21:46','2019-08-28 02:21:46','d6996700-c76b-4630-96d4-2e535eefff9a'),
	(2,'Place','2019-08-28 03:08:45','2019-08-28 03:08:45','7a1a920c-b2f0-42bd-a4f4-d90d7c529717'),
	(3,'Person','2019-08-28 03:08:46','2019-08-28 03:08:46','7c4fda01-a7dd-465d-bcfa-21d72991cac7');
ALTER TABLE `mod_fieldgroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldlayouttabs` WRITE;
ALTER TABLE `mod_fieldlayouttabs` DISABLE KEYS;
REPLACE INTO `mod_fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,'Content',1,'2019-08-28 03:09:26','2019-08-28 03:09:26','6e5be4b6-dff0-4057-acf8-3b8018621ac9'),
	(2,2,'Person',1,'2019-08-28 03:09:36','2019-08-28 03:09:36','7ed4dab9-d9cd-4f39-86a3-78562383842e'),
	(3,2,'Related',2,'2019-08-28 03:09:36','2019-08-28 03:09:36','2e18511f-ab8d-4237-9af2-2aa8ae1c7201'),
	(4,3,'Campus',1,'2019-08-28 03:09:36','2019-08-28 03:09:36','88679b61-d225-4132-aca3-bd811906a687'),
	(5,3,'System',2,'2019-08-28 03:09:36','2019-08-28 03:09:36','6c45b5a4-89fa-4f0d-a40b-1ee50b9e6d60'),
	(6,4,'Building',1,'2019-08-28 03:09:37','2019-08-28 03:09:37','cfcc85c8-a7f5-4304-9238-2294fd4b95df'),
	(7,4,'System',2,'2019-08-28 03:09:37','2019-08-28 03:09:37','0ab745b7-b1f9-4f76-ae6b-83844b1a54ef'),
	(8,5,'Floor',1,'2019-08-28 03:09:37','2019-08-28 03:09:37','0b6f79a9-ef1a-4738-b5a7-bb161c258387'),
	(9,5,'System',2,'2019-08-28 03:09:37','2019-08-28 03:09:37','6b61ce3d-272d-407e-9357-4084362640aa'),
	(10,6,'Room',1,'2019-08-28 03:09:37','2019-08-28 03:09:37','90754e97-9994-4521-85a3-1a6141c0e4e4'),
	(11,6,'System',2,'2019-08-28 03:09:37','2019-08-28 03:09:37','9f82824c-61db-46e2-8ae9-6fab5f16e229');
ALTER TABLE `mod_fieldlayouttabs` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fields` WRITE;
ALTER TABLE `mod_fields` DISABLE KEYS;
REPLACE INTO `mod_fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `searchable`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,2,'Campus Key','campusKey','global','For internal use only',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:08:47','2019-08-28 03:08:47','588f91c4-2142-4791-94ff-d68943c22672'),
	(2,2,'Campus Name','campusName','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:08:49','2019-08-28 03:08:49','df1b8f4d-a1bf-4535-8fdd-0d768ad25bde'),
	(3,2,'Campus Description','campusDescription','global','',1,'none',NULL,'craft\\redactor\\Field','{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"}','2019-08-28 03:08:50','2019-08-28 03:08:50','a5d2db21-b057-42af-8d18-c445d5e872e7'),
	(4,2,'Campus Map','campusMap','global','',1,'site',NULL,'craft\\fields\\Assets','{"useSingleFolder":"1","defaultUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","defaultUploadLocationSubpath":"","singleUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","singleUploadLocationSubpath":"campus/maps","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add campus map","localizeRelations":false,"validateRelatedElements":""}','2019-08-28 03:08:51','2019-08-28 03:08:51','759dd586-0869-4984-be91-f5b6ccc047ab'),
	(5,2,'Campus Photo','campusPhoto','global','',1,'site',NULL,'craft\\fields\\Assets','{"useSingleFolder":"1","defaultUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","defaultUploadLocationSubpath":"","singleUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","singleUploadLocationSubpath":"campus/photos","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add campus photo","localizeRelations":false,"validateRelatedElements":""}','2019-08-28 03:08:51','2019-08-28 03:08:51','892d2117-df31-441d-bd2f-28b42607d9f0'),
	(6,2,'Building Key','buildingKey','global','For internal use only',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:08:52','2019-08-28 03:08:52','13ad30d7-b9a4-4887-8f25-59ac6e7dff39'),
	(7,2,'Building Name','buildingName','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:08:54','2019-08-28 03:08:54','0f8b0a16-27cc-462f-b767-79bb5bfb380e'),
	(8,2,'Building Description','buildingDescription','global','',1,'none',NULL,'craft\\redactor\\Field','{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"}','2019-08-28 03:08:56','2019-08-28 03:08:56','6d8896e0-54d4-4677-8787-feb0126aa1da'),
	(9,2,'Building Photo','BuildingPhoto','global','',1,'site',NULL,'craft\\fields\\Assets','{"useSingleFolder":"1","defaultUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","defaultUploadLocationSubpath":"","singleUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","singleUploadLocationSubpath":"building/photos","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add building photo","localizeRelations":false,"validateRelatedElements":""}','2019-08-28 03:08:57','2019-08-28 03:08:57','5044fb40-a56c-4cf7-aca2-73dfc038e279'),
	(10,2,'Building Address','buildingAddress','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:08:58','2019-08-28 03:08:58','2866f56d-d8f3-40c0-88ac-7d23de2466f1'),
	(11,2,'Building City','buildingCity','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:00','2019-08-28 03:09:00','0f53b91e-8b9a-4b08-8960-239d72240ee6'),
	(12,2,'Building State','buildingState','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:02','2019-08-28 03:09:02','3f98ecf3-f219-40e8-a02d-456db508e39a'),
	(13,2,'Building Zipcode','buildingZipcode','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:04','2019-08-28 03:09:04','fb106af1-70f4-43eb-a98f-c511c826140f'),
	(14,2,'Floor Key','floorKey','global','For internal use only',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:06','2019-08-28 03:09:06','aeba1b46-d00d-4405-b420-2c294b3f336a'),
	(15,2,'Floor Number','floorNumber','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:08','2019-08-28 03:09:08','8520f971-900e-43f6-858f-01eeb74c0057'),
	(16,2,'Floor Map','floorMap','global','',1,'site',NULL,'craft\\fields\\Assets','{"useSingleFolder":"","defaultUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","defaultUploadLocationSubpath":"floor/maps","singleUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","singleUploadLocationSubpath":"","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add floor map","localizeRelations":false,"validateRelatedElements":""}','2019-08-28 03:09:08','2019-08-28 03:09:08','50f53a87-c018-49b9-84aa-789a61d0c92a'),
	(17,3,'Person Key','personKey','global','For internal use only',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:09','2019-08-28 03:09:09','9ac16c49-da42-4de5-bbb0-1e7e6d8efed2'),
	(18,3,'Person First Name','personFirstName','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:11','2019-08-28 03:09:11','59eae662-5513-45a0-8a07-12107efa41b6'),
	(19,3,'Person Last Name','personLastName','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:13','2019-08-28 03:09:13','28217dcb-a5f2-42c4-8a1b-dcdaa80bfe63'),
	(20,2,'Person Photo','personPhoto','global','',1,'site',NULL,'craft\\fields\\Assets','{"useSingleFolder":"1","defaultUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","defaultUploadLocationSubpath":"","singleUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","singleUploadLocationSubpath":"people/photos","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add person photo","localizeRelations":false,"validateRelatedElements":""}','2019-08-28 03:09:14','2019-08-28 03:09:14','11ed86f7-23c2-4c32-b92a-85b42cdca281'),
	(21,3,'Person Description','personDescription','global','A short bio or profile summary about this person',1,'none',NULL,'craft\\redactor\\Field','{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"}','2019-08-28 03:09:15','2019-08-28 03:09:15','9e27d1cd-82e6-46ed-9be2-5690e57dac39'),
	(22,3,'Person Email','personEmail','global','',1,'none',NULL,'craft\\fields\\Email','{"placeholder":""}','2019-08-28 03:09:17','2019-08-28 03:09:17','bc866b64-6b9b-47b8-8df2-217636f4128c'),
	(23,3,'Person Phone','personPhone','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:19','2019-08-28 03:09:19','16472fa3-ed69-442d-8020-c74688e5afb8'),
	(24,3,'Person Related Place','personRelatedPlace','global','',1,'site',NULL,'craft\\fields\\Entries','{"sources":["section:2c0c1a7e-f890-4904-a132-cd347cc17da7"],"source":null,"targetSiteId":null,"viewMode":null,"limit":"1","selectionLabel":"Add related place","localizeRelations":false,"validateRelatedElements":""}','2019-08-28 03:09:19','2019-08-28 03:09:19','f0d0b88b-7a5b-4a8e-a4b9-b483126de833'),
	(25,3,'Person Roles','personRoles','global','',1,'site',NULL,'craft\\fields\\Matrix','{"minBlocks":"","maxBlocks":"","contentTable":"{{%matrixcontent_personroles}}","propagationMethod":"all"}','2019-08-28 03:09:21','2019-08-28 03:09:21','88b349fa-ea83-491b-bf93-47854227c85a'),
	(26,NULL,'Department','roleDepartment','matrixBlockType:6b7ca11e-f601-4a33-9bc8-490992019c43','',1,'site',NULL,'craft\\fields\\Categories','{"allowLimit":false,"allowMultipleSources":false,"branchLimit":"1","sources":"*","source":"group:343f1098-6cf9-4957-8533-ae04e7eb2a7a","targetSiteId":null,"viewMode":null,"limit":null,"selectionLabel":"Add department","localizeRelations":false,"validateRelatedElements":""}','2019-08-28 03:09:23','2019-08-28 03:09:23','10cd6d5e-be0b-4fbc-af0d-b036194ed3bd'),
	(27,NULL,'Title','roleTitle','matrixBlockType:6b7ca11e-f601-4a33-9bc8-490992019c43','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:24','2019-08-28 03:09:24','73f5b646-549d-4370-9c4d-1a58afac5175'),
	(28,2,'Room Key','roomKey','global','For internal use only',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:29','2019-08-28 03:09:29','f8687b54-0cf1-4db0-8b8d-36f0e25ec9af'),
	(29,2,'Place Marker','placeMarker','global','',1,'none',NULL,'selvinortiz\\smartfields\\fields\\MarkerCoordinatesField','{"x":null,"y":null}','2019-08-28 03:09:31','2019-08-28 03:09:31','c264ee78-4d0d-4623-8187-65f1f91df1a9'),
	(30,2,'Room Description','roomDescription','global','',1,'none',NULL,'craft\\redactor\\Field','{"redactorConfig":"","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"}','2019-08-28 03:09:32','2019-08-28 03:09:32','20d5fded-251d-44fd-b460-3760e03a11c9'),
	(31,2,'Room Number','roomNumber','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-28 03:09:34','2019-08-28 03:09:34','6c17a222-07fc-40f6-9fd7-229e1b0ea9fc');
ALTER TABLE `mod_fields` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldlayoutfields` WRITE;
ALTER TABLE `mod_fieldlayoutfields` DISABLE KEYS;
REPLACE INTO `mod_fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,26,1,2,'2019-08-28 03:09:26','2019-08-28 03:09:26','cf28e9be-98b8-41c6-bf90-74ccff06fb87'),
	(2,1,1,27,1,1,'2019-08-28 03:09:26','2019-08-28 03:09:26','fac3e2d0-494c-49d4-8519-b14ebe1c14a3'),
	(3,2,2,20,0,1,'2019-08-28 03:09:36','2019-08-28 03:09:36','ef7e2e61-bff7-4ff6-b8aa-8b3b855e0227'),
	(4,2,2,23,0,5,'2019-08-28 03:09:36','2019-08-28 03:09:36','626b386f-9169-49a9-a477-b7122aba5d2b'),
	(5,2,2,19,1,3,'2019-08-28 03:09:36','2019-08-28 03:09:36','b550e189-c603-4e85-ac0a-4191a39ec8d7'),
	(6,2,2,18,1,2,'2019-08-28 03:09:36','2019-08-28 03:09:36','21bcda3e-acf9-43c8-a156-04cdcfd7766c'),
	(7,2,2,25,0,7,'2019-08-28 03:09:36','2019-08-28 03:09:36','9fa6dd30-d759-4d2c-ba9a-ee001c300734'),
	(8,2,2,21,0,6,'2019-08-28 03:09:36','2019-08-28 03:09:36','4d390710-da1a-40a8-a59e-b01bf2e7eb6b'),
	(9,2,2,22,1,4,'2019-08-28 03:09:36','2019-08-28 03:09:36','b0a77798-c93c-42e9-818c-84a428b3bf45'),
	(10,2,3,24,0,1,'2019-08-28 03:09:36','2019-08-28 03:09:36','fb46434c-e2ae-4f09-b4b1-1a68d21a3c7e'),
	(11,3,4,4,0,4,'2019-08-28 03:09:36','2019-08-28 03:09:36','1acdcc5d-59e3-415a-8152-71607f7356c9'),
	(12,3,4,5,0,1,'2019-08-28 03:09:36','2019-08-28 03:09:36','2a017342-1857-4aa7-9766-fed95ef1f49e'),
	(13,3,4,3,0,3,'2019-08-28 03:09:36','2019-08-28 03:09:36','86ee1610-3364-47b0-b1b2-37bf8da42d17'),
	(14,3,4,2,1,2,'2019-08-28 03:09:36','2019-08-28 03:09:36','e9b7f331-aaed-4769-9fc3-20111b5f6f91'),
	(15,3,5,1,0,1,'2019-08-28 03:09:36','2019-08-28 03:09:36','4ec27a00-2542-4a05-ac59-a1e5fe3966be'),
	(16,4,6,7,1,2,'2019-08-28 03:09:37','2019-08-28 03:09:37','1ed4fd7c-fdf4-4f5e-9e07-0047d4691c95'),
	(17,4,6,8,0,3,'2019-08-28 03:09:37','2019-08-28 03:09:37','498da867-1c19-4b3a-9da1-c370e0d75f98'),
	(18,4,7,6,0,1,'2019-08-28 03:09:37','2019-08-28 03:09:37','122dd074-99cc-49b0-b41d-05e8148b49c8'),
	(19,4,7,29,0,2,'2019-08-28 03:09:37','2019-08-28 03:09:37','140f7935-edbe-434d-bd6e-746b47990ee0'),
	(20,5,8,16,0,2,'2019-08-28 03:09:37','2019-08-28 03:09:37','4fb69068-6048-400c-a7f5-df4c34c90452'),
	(21,5,8,15,1,1,'2019-08-28 03:09:37','2019-08-28 03:09:37','067ea109-16fe-4ac2-8afa-45eb1ea418c3'),
	(22,5,9,14,1,1,'2019-08-28 03:09:37','2019-08-28 03:09:37','62fe9fed-1cd7-4378-9d3e-819257a8bab6'),
	(23,6,10,30,0,2,'2019-08-28 03:09:37','2019-08-28 03:09:37','b79064aa-fea7-4b23-89aa-52662136d08d'),
	(24,6,10,31,1,1,'2019-08-28 03:09:37','2019-08-28 03:09:37','acdd784c-304a-4b06-9dd3-17ef450fb018'),
	(25,6,11,29,0,2,'2019-08-28 03:09:37','2019-08-28 03:09:37','053fc7ab-105a-4b1e-8423-59f064076225'),
	(26,6,11,28,1,1,'2019-08-28 03:09:37','2019-08-28 03:09:37','b4a1ac49-383d-4a4d-bae1-27d016591f48');
ALTER TABLE `mod_fieldlayoutfields` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_globalsets` WRITE;
ALTER TABLE `mod_globalsets` DISABLE KEYS;
ALTER TABLE `mod_globalsets` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_gqlschemas` WRITE;
ALTER TABLE `mod_gqlschemas` DISABLE KEYS;
ALTER TABLE `mod_gqlschemas` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_info` WRITE;
ALTER TABLE `mod_info` DISABLE KEYS;
REPLACE INTO `mod_info` (`id`, `version`, `schemaVersion`, `maintenance`, `config`, `configMap`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,'3.3.0.1','3.3.3',0,'{"fieldGroups":{"d6996700-c76b-4630-96d4-2e535eefff9a":{"name":"Common"},"7a1a920c-b2f0-42bd-a4f4-d90d7c529717":{"name":"Place"},"7c4fda01-a7dd-465d-bcfa-21d72991cac7":{"name":"Person"}},"siteGroups":{"505c19d2-64bf-4ead-a137-ee5848e9f3c3":{"name":"ModCore"}},"sites":{"86cb8f50-93a8-4e48-b08a-a74fc1941e97":{"baseUrl":"$DEFAULT_SITE_URL","handle":"default","hasUrls":true,"language":"en-US","name":"ModCore","primary":true,"siteGroup":"505c19d2-64bf-4ead-a137-ee5848e9f3c3","sortOrder":1}},"email":{"fromEmail":"selvin@modcreativeinc.com","fromName":"ModCore","transportType":"craft\\\\mail\\\\transportadapters\\\\Sendmail"},"system":{"edition":"solo","name":"ModCore","live":true,"schemaVersion":"3.3.3","timeZone":"America/Los_Angeles"},"users":{"requireEmailVerification":true,"allowPublicRegistration":false,"defaultGroup":null,"photoVolumeUid":null,"photoSubpath":""},"dateModified":1566961724,"plugins":{"redactor":{"edition":"standard","enabled":true,"schemaVersion":"2.3.0"},"architect":{"edition":"standard","enabled":true,"schemaVersion":"2.0.0"},"smart-fields":{"edition":"standard","enabled":true,"schemaVersion":"1.0.0"},"hidden-fields":{"edition":"standard","enabled":true,"schemaVersion":"1.0.0"}},"sections":{"b796c1d1-b641-44ea-8128-02bc18f65fcc":{"name":"People","handle":"people","type":"structure","enableVersioning":false,"propagationMethod":"all","siteSettings":{"86cb8f50-93a8-4e48-b08a-a74fc1941e97":{"enabledByDefault":false,"hasUrls":false,"uriFormat":null,"template":null}},"structure":{"uid":"b2b34f31-0d3b-43d7-beed-468b1b3a10a6","maxLevels":1},"entryTypes":{"c3a36f21-5c6b-42e4-b6ea-8e8b7e1204a4":{"name":"Person","handle":"person","hasTitleField":false,"titleLabel":"Title","titleFormat":"{personFirstName} {personLastName}","sortOrder":2,"fieldLayouts":{"a100f5ff-998d-47a7-8a5e-d0170cb56cf6":{"tabs":[{"name":"Person","sortOrder":1,"fields":{"11ed86f7-23c2-4c32-b92a-85b42cdca281":{"required":false,"sortOrder":1},"16472fa3-ed69-442d-8020-c74688e5afb8":{"required":false,"sortOrder":5},"28217dcb-a5f2-42c4-8a1b-dcdaa80bfe63":{"required":true,"sortOrder":3},"59eae662-5513-45a0-8a07-12107efa41b6":{"required":true,"sortOrder":2},"88b349fa-ea83-491b-bf93-47854227c85a":{"required":false,"sortOrder":7},"9e27d1cd-82e6-46ed-9be2-5690e57dac39":{"required":false,"sortOrder":6},"bc866b64-6b9b-47b8-8df2-217636f4128c":{"required":true,"sortOrder":4}}},{"name":"Related","sortOrder":2,"fields":{"f0d0b88b-7a5b-4a8e-a4b9-b483126de833":{"required":false,"sortOrder":1}}}]}}}}},"2c0c1a7e-f890-4904-a132-cd347cc17da7":{"name":"Places","handle":"places","type":"structure","enableVersioning":true,"propagationMethod":"all","siteSettings":{"86cb8f50-93a8-4e48-b08a-a74fc1941e97":{"enabledByDefault":true,"hasUrls":false,"uriFormat":null,"template":null}},"structure":{"uid":"9c6c0d8d-d006-41be-a487-7113b6241238","maxLevels":5},"entryTypes":{"093dfa29-a3d3-49b0-a677-f37bf3a9a1c4":{"name":"Campus","handle":"campus","hasTitleField":false,"titleLabel":"Title","titleFormat":"Campus - {campusName}","sortOrder":2,"fieldLayouts":{"9c28951f-89c6-4e9d-a77b-073ffabd4a5b":{"tabs":[{"name":"Campus","sortOrder":1,"fields":{"759dd586-0869-4984-be91-f5b6ccc047ab":{"required":false,"sortOrder":4},"892d2117-df31-441d-bd2f-28b42607d9f0":{"required":false,"sortOrder":1},"a5d2db21-b057-42af-8d18-c445d5e872e7":{"required":false,"sortOrder":3},"df1b8f4d-a1bf-4535-8fdd-0d768ad25bde":{"required":true,"sortOrder":2}}},{"name":"System","sortOrder":2,"fields":{"588f91c4-2142-4791-94ff-d68943c22672":{"required":false,"sortOrder":1}}}]}}},"c814d1a0-895d-4407-8635-94e0afc1ea2b":{"name":"Building","handle":"building","hasTitleField":false,"titleLabel":"Title","titleFormat":"Building - {buildingName}","sortOrder":3,"fieldLayouts":{"5cfb5bd6-349f-40b8-896f-234c457c46fe":{"tabs":[{"name":"Building","sortOrder":1,"fields":{"0f8b0a16-27cc-462f-b767-79bb5bfb380e":{"required":true,"sortOrder":2},"6d8896e0-54d4-4677-8787-feb0126aa1da":{"required":false,"sortOrder":3}}},{"name":"System","sortOrder":2,"fields":{"13ad30d7-b9a4-4887-8f25-59ac6e7dff39":{"required":false,"sortOrder":1},"c264ee78-4d0d-4623-8187-65f1f91df1a9":{"required":false,"sortOrder":2}}}]}}},"08f47a8f-1a6c-46e6-8bf6-1f056246b083":{"name":"Floor","handle":"floor","hasTitleField":false,"titleLabel":"Title","titleFormat":"Floor {floorNumber}","sortOrder":4,"fieldLayouts":{"36786489-8f02-4c52-b9af-03c6508d969e":{"tabs":[{"name":"Floor","sortOrder":1,"fields":{"50f53a87-c018-49b9-84aa-789a61d0c92a":{"required":false,"sortOrder":2},"8520f971-900e-43f6-858f-01eeb74c0057":{"required":true,"sortOrder":1}}},{"name":"System","sortOrder":2,"fields":{"aeba1b46-d00d-4405-b420-2c294b3f336a":{"required":true,"sortOrder":1}}}]}}},"b1e551b2-4335-4c4e-80e3-25359e851bc0":{"name":"Room","handle":"room","hasTitleField":false,"titleLabel":"Title","titleFormat":"Room {roomNumber}","sortOrder":5,"fieldLayouts":{"c16b2877-1a8f-44ff-8bda-2a36ba707185":{"tabs":[{"name":"Room","sortOrder":1,"fields":{"20d5fded-251d-44fd-b460-3760e03a11c9":{"required":false,"sortOrder":2},"6c17a222-07fc-40f6-9fd7-229e1b0ea9fc":{"required":true,"sortOrder":1}}},{"name":"System","sortOrder":2,"fields":{"c264ee78-4d0d-4623-8187-65f1f91df1a9":{"required":false,"sortOrder":2},"f8687b54-0cf1-4db0-8b8d-36f0e25ec9af":{"required":true,"sortOrder":1}}}]}}}}}},"volumes":{"06bbe7b5-3976-4c75-a2c7-a01ea0867363":{"name":"Uploads","handle":"uploads","type":"craft\\\\volumes\\\\Local","hasUrls":true,"url":"@web/uploads","settings":{"path":"@webroot/uploads"},"sortOrder":1},"ee642d92-dde6-4de6-b53c-4537b3478500":{"name":"System","handle":"system","type":"craft\\\\volumes\\\\Local","hasUrls":true,"url":"@web/system","settings":{"path":"@webroot/system"},"sortOrder":2}},"categoryGroups":{"343f1098-6cf9-4957-8533-ae04e7eb2a7a":{"name":"Departments","handle":"departments","structure":{"uid":"d055a3ea-72c4-4eca-8b57-9a5ca9d9e939","maxLevels":1},"siteSettings":{"86cb8f50-93a8-4e48-b08a-a74fc1941e97":{"hasUrls":true,"uriFormat":"departments/{slug}","template":""}}}},"fields":{"588f91c4-2142-4791-94ff-d68943c22672":{"name":"Campus Key","handle":"campusKey","instructions":"For internal use only","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"df1b8f4d-a1bf-4535-8fdd-0d768ad25bde":{"name":"Campus Name","handle":"campusName","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"a5d2db21-b057-42af-8d18-c445d5e872e7":{"name":"Campus Description","handle":"campusDescription","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\redactor\\\\Field","settings":{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"759dd586-0869-4984-be91-f5b6ccc047ab":{"name":"Campus Map","handle":"campusMap","instructions":"","searchable":true,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Assets","settings":{"useSingleFolder":"1","defaultUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","defaultUploadLocationSubpath":"","singleUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","singleUploadLocationSubpath":"campus/maps","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add campus map","localizeRelations":false,"validateRelatedElements":""},"contentColumnType":"string","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"892d2117-df31-441d-bd2f-28b42607d9f0":{"name":"Campus Photo","handle":"campusPhoto","instructions":"","searchable":true,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Assets","settings":{"useSingleFolder":"1","defaultUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","defaultUploadLocationSubpath":"","singleUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","singleUploadLocationSubpath":"campus/photos","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add campus photo","localizeRelations":false,"validateRelatedElements":""},"contentColumnType":"string","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"13ad30d7-b9a4-4887-8f25-59ac6e7dff39":{"name":"Building Key","handle":"buildingKey","instructions":"For internal use only","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"0f8b0a16-27cc-462f-b767-79bb5bfb380e":{"name":"Building Name","handle":"buildingName","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"6d8896e0-54d4-4677-8787-feb0126aa1da":{"name":"Building Description","handle":"buildingDescription","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\redactor\\\\Field","settings":{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"5044fb40-a56c-4cf7-aca2-73dfc038e279":{"name":"Building Photo","handle":"BuildingPhoto","instructions":"","searchable":true,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Assets","settings":{"useSingleFolder":"1","defaultUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","defaultUploadLocationSubpath":"","singleUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","singleUploadLocationSubpath":"building/photos","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add building photo","localizeRelations":false,"validateRelatedElements":""},"contentColumnType":"string","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"2866f56d-d8f3-40c0-88ac-7d23de2466f1":{"name":"Building Address","handle":"buildingAddress","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"0f53b91e-8b9a-4b08-8960-239d72240ee6":{"name":"Building City","handle":"buildingCity","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"3f98ecf3-f219-40e8-a02d-456db508e39a":{"name":"Building State","handle":"buildingState","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"fb106af1-70f4-43eb-a98f-c511c826140f":{"name":"Building Zipcode","handle":"buildingZipcode","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"aeba1b46-d00d-4405-b420-2c294b3f336a":{"name":"Floor Key","handle":"floorKey","instructions":"For internal use only","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"8520f971-900e-43f6-858f-01eeb74c0057":{"name":"Floor Number","handle":"floorNumber","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"50f53a87-c018-49b9-84aa-789a61d0c92a":{"name":"Floor Map","handle":"floorMap","instructions":"","searchable":true,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Assets","settings":{"useSingleFolder":"","defaultUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","defaultUploadLocationSubpath":"floor/maps","singleUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","singleUploadLocationSubpath":"","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add floor map","localizeRelations":false,"validateRelatedElements":""},"contentColumnType":"string","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"9ac16c49-da42-4de5-bbb0-1e7e6d8efed2":{"name":"Person Key","handle":"personKey","instructions":"For internal use only","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7c4fda01-a7dd-465d-bcfa-21d72991cac7"},"59eae662-5513-45a0-8a07-12107efa41b6":{"name":"Person First Name","handle":"personFirstName","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7c4fda01-a7dd-465d-bcfa-21d72991cac7"},"28217dcb-a5f2-42c4-8a1b-dcdaa80bfe63":{"name":"Person Last Name","handle":"personLastName","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7c4fda01-a7dd-465d-bcfa-21d72991cac7"},"11ed86f7-23c2-4c32-b92a-85b42cdca281":{"name":"Person Photo","handle":"personPhoto","instructions":"","searchable":true,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Assets","settings":{"useSingleFolder":"1","defaultUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","defaultUploadLocationSubpath":"","singleUploadLocationSource":"volume:06bbe7b5-3976-4c75-a2c7-a01ea0867363","singleUploadLocationSubpath":"people/photos","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add person photo","localizeRelations":false,"validateRelatedElements":""},"contentColumnType":"string","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"9e27d1cd-82e6-46ed-9be2-5690e57dac39":{"name":"Person Description","handle":"personDescription","instructions":"A short bio or profile summary about this person","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\redactor\\\\Field","settings":{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"},"contentColumnType":"text","fieldGroup":"7c4fda01-a7dd-465d-bcfa-21d72991cac7"},"bc866b64-6b9b-47b8-8df2-217636f4128c":{"name":"Person Email","handle":"personEmail","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\Email","settings":{"placeholder":""},"contentColumnType":"string","fieldGroup":"7c4fda01-a7dd-465d-bcfa-21d72991cac7"},"16472fa3-ed69-442d-8020-c74688e5afb8":{"name":"Person Phone","handle":"personPhone","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7c4fda01-a7dd-465d-bcfa-21d72991cac7"},"f0d0b88b-7a5b-4a8e-a4b9-b483126de833":{"name":"Person Related Place","handle":"personRelatedPlace","instructions":"","searchable":true,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Entries","settings":{"sources":["section:2c0c1a7e-f890-4904-a132-cd347cc17da7"],"source":null,"targetSiteId":null,"viewMode":null,"limit":"1","selectionLabel":"Add related place","localizeRelations":false,"validateRelatedElements":""},"contentColumnType":"string","fieldGroup":"7c4fda01-a7dd-465d-bcfa-21d72991cac7"},"88b349fa-ea83-491b-bf93-47854227c85a":{"name":"Person Roles","handle":"personRoles","instructions":"","searchable":true,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Matrix","settings":{"minBlocks":"","maxBlocks":"","contentTable":"{{%matrixcontent_personroles}}","propagationMethod":"all"},"contentColumnType":"string","fieldGroup":"7c4fda01-a7dd-465d-bcfa-21d72991cac7"},"f8687b54-0cf1-4db0-8b8d-36f0e25ec9af":{"name":"Room Key","handle":"roomKey","instructions":"For internal use only","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"c264ee78-4d0d-4623-8187-65f1f91df1a9":{"name":"Place Marker","handle":"placeMarker","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"selvinortiz\\\\smartfields\\\\fields\\\\MarkerCoordinatesField","settings":{"x":null,"y":null},"contentColumnType":"string","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"20d5fded-251d-44fd-b460-3760e03a11c9":{"name":"Room Description","handle":"roomDescription","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\redactor\\\\Field","settings":{"redactorConfig":"","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"},"6c17a222-07fc-40f6-9fd7-229e1b0ea9fc":{"name":"Room Number","handle":"roomNumber","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"7a1a920c-b2f0-42bd-a4f4-d90d7c529717"}},"matrixBlockTypes":{"6b7ca11e-f601-4a33-9bc8-490992019c43":{"field":"88b349fa-ea83-491b-bf93-47854227c85a","name":"Role","handle":"role","sortOrder":1,"fields":{"10cd6d5e-be0b-4fbc-af0d-b036194ed3bd":{"name":"Department","handle":"roleDepartment","instructions":"","searchable":true,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Categories","settings":{"allowLimit":false,"allowMultipleSources":false,"branchLimit":"1","sources":"*","source":"group:343f1098-6cf9-4957-8533-ae04e7eb2a7a","targetSiteId":null,"viewMode":null,"limit":null,"selectionLabel":"Add department","localizeRelations":false,"validateRelatedElements":""},"contentColumnType":"string","fieldGroup":null},"73f5b646-549d-4370-9c4d-1a58afac5175":{"name":"Title","handle":"roleTitle","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":null}},"fieldLayouts":{"814be701-eac9-4e27-838d-2f4b23a3308f":{"tabs":[{"name":"Content","sortOrder":1,"fields":{"10cd6d5e-be0b-4fbc-af0d-b036194ed3bd":{"required":true,"sortOrder":2},"73f5b646-549d-4370-9c4d-1a58afac5175":{"required":true,"sortOrder":1}}}]}}}}}','[]','WDz9kPgns6Mh','2019-08-28 02:21:45','2019-08-28 02:21:45','a84e761f-1b53-462a-8dbc-8762647328eb');
ALTER TABLE `mod_info` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_matrixblocktypes` WRITE;
ALTER TABLE `mod_matrixblocktypes` DISABLE KEYS;
REPLACE INTO `mod_matrixblocktypes` (`id`, `fieldId`, `fieldLayoutId`, `name`, `handle`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,25,1,'Role','role',1,'2019-08-28 03:09:26','2019-08-28 03:09:26','6b7ca11e-f601-4a33-9bc8-490992019c43');
ALTER TABLE `mod_matrixblocktypes` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_matrixblocks` WRITE;
ALTER TABLE `mod_matrixblocks` DISABLE KEYS;
ALTER TABLE `mod_matrixblocks` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_matrixcontent_personroles` WRITE;
ALTER TABLE `mod_matrixcontent_personroles` DISABLE KEYS;
ALTER TABLE `mod_matrixcontent_personroles` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_plugins` WRITE;
ALTER TABLE `mod_plugins` DISABLE KEYS;
REPLACE INTO `mod_plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKeyStatus`, `licensedEdition`, `installDate`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,'redactor','2.3.3.2','2.3.0','unknown',NULL,'2019-08-28 02:23:08','2019-08-28 02:23:08','2019-08-28 02:23:08','613d1733-3ae6-4cbf-becb-c6acb1a1d9d9'),
	(2,'architect','2.3.1','2.0.0','unknown',NULL,'2019-08-28 02:32:28','2019-08-28 02:32:28','2019-08-28 02:32:28','0b93f7ff-ee64-4fff-82ab-def634f18984'),
	(3,'smart-fields','1.0.0','1.0.0','unknown',NULL,'2019-08-28 02:46:15','2019-08-28 02:46:15','2019-08-28 02:46:15','0b1cbe63-bae7-4c97-be4c-f433c44c9a08'),
	(4,'hidden-fields','1.1.0','1.0.0','unknown',NULL,'2019-08-28 02:47:29','2019-08-28 02:47:29','2019-08-28 02:47:29','dc80b8c7-aa58-46d6-99e7-e6b7e45c5920');
ALTER TABLE `mod_plugins` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_migrations` WRITE;
ALTER TABLE `mod_migrations` DISABLE KEYS;
REPLACE INTO `mod_migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,NULL,'app','Install','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','08603f23-359b-4086-8a65-247e79fd0e4f'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','f189d2a3-bd72-40f5-ac0d-dd9938f1db31'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','c0178ce4-4523-45ea-ac23-3f2c018b27c4'),
	(4,NULL,'app','m150403_184533_field_version','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','c2dc55e3-8edd-4665-9ee6-9e098b19580f'),
	(5,NULL,'app','m150403_184729_type_columns','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','90394f48-84a9-4bcb-aaa2-c15594b534e5'),
	(6,NULL,'app','m150403_185142_volumes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','687e1c23-f9c0-4491-a4f4-60b162a96ede'),
	(7,NULL,'app','m150428_231346_userpreferences','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','7566ef51-f710-491e-860b-992b2768859a'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','e785ae43-6921-470e-a42b-37cecc028b99'),
	(9,NULL,'app','m150617_213829_update_email_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','a5ef625b-e2f7-4961-8ee8-a8a453843faa'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','370a3bac-fc7a-4a9d-8500-f868c3371b82'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','fbcb5bfd-6107-4199-81fa-5148581246ea'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','8cf2958e-a251-4273-92cd-ea1d6a6cc791'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','045b2843-a404-431f-899c-7d209f76b5d0'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','a275fe29-d12d-4192-98ca-0f43181e2337'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','85ed3315-e51b-43d2-87f9-a82195d6d94f'),
	(16,NULL,'app','m151209_000000_move_logo','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','4ef8df1c-34da-4570-bdad-7fb98ff69a59'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','939fd21b-8454-4848-8381-1a7d7ee3cf77'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','cd009981-7f93-4cb7-844f-0d37fea86d69'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','070133c2-8098-4147-b4aa-29af6a12ad4f'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','c7a2a28e-6d66-4896-be1e-cf177fccb921'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','53787b24-2b66-4b4b-8066-2cf7256b9865'),
	(22,NULL,'app','m160727_194637_column_cleanup','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','4ae86206-22a7-47a3-a29d-2d544b22c2d0'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','d39a5096-1af5-49c9-a99b-9b2b8b5c2e9e'),
	(24,NULL,'app','m160807_144858_sites','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','8df3b987-0164-4028-8995-8eebc3c5dc62'),
	(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','6637de27-2c29-499a-8a6d-8e934073f6ce'),
	(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','c9720529-00d0-4a22-b1e7-c92649c4c01b'),
	(27,NULL,'app','m160912_230520_require_entry_type_id','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','faa4b119-50da-4ec0-914f-55e782e23add'),
	(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','cbfeb18c-81e4-4270-a7c3-3860a75ffd51'),
	(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','791dfc9e-dfc6-435c-b044-0bf2a5f0cffc'),
	(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','c3a56185-6405-4eac-869d-5d4d48ed528b'),
	(31,NULL,'app','m160925_113941_route_uri_parts','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','29441e4f-13a1-49e7-8e24-8a5ec4e052ae'),
	(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','e4955c71-6c72-4fbd-aa38-e1ce52d9ec05'),
	(33,NULL,'app','m161007_130653_update_email_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','8343aac7-cae2-43d8-8c0a-fa2d02ca5c8b'),
	(34,NULL,'app','m161013_175052_newParentId','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','55c13f09-a950-47cc-a88a-113c99d5aa55'),
	(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','8cbc6f93-3353-4e37-b539-08ae79743600'),
	(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','bea1471d-f792-4eed-bb38-475bc972598e'),
	(37,NULL,'app','m161025_000000_fix_char_columns','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','e4ee4b68-f8b8-4adc-aacf-5b21b37a45a5'),
	(38,NULL,'app','m161029_124145_email_message_languages','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','5f55c1f6-2213-4193-9b75-6d93f96650e8'),
	(39,NULL,'app','m161108_000000_new_version_format','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','063883db-318b-4a0e-b597-0634ddfa48b4'),
	(40,NULL,'app','m161109_000000_index_shuffle','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','99f49ca3-68e0-4252-ad90-e88bfdffdf40'),
	(41,NULL,'app','m161122_185500_no_craft_app','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','31526a08-7d01-422d-b464-4fce2a19cccf'),
	(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','577dd1dc-0229-44ea-948f-375ed8faaceb'),
	(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','15e33410-9ee5-42a8-9074-a1e2906b7379'),
	(44,NULL,'app','m170114_161144_udates_permission','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','df9be6c9-fbd3-4204-b876-a5a3e666e45f'),
	(45,NULL,'app','m170120_000000_schema_cleanup','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','53f9a749-e4b3-44d1-a1a7-3ae052033a67'),
	(46,NULL,'app','m170126_000000_assets_focal_point','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','80be3026-6855-4a6a-9c57-c8ca17134dcf'),
	(47,NULL,'app','m170206_142126_system_name','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','ce0d3256-8617-4382-a6b4-3bf0235be188'),
	(48,NULL,'app','m170217_044740_category_branch_limits','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','6e592b25-61ff-4284-9cf2-be36c396f0b3'),
	(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','74935d1e-22fc-4412-a706-7b942c08edcd'),
	(50,NULL,'app','m170223_224012_plain_text_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','68d28e04-9723-4c84-8008-8254e90e421b'),
	(51,NULL,'app','m170227_120814_focal_point_percentage','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','cce432b5-ae74-4074-b7ac-a3eb3825f683'),
	(52,NULL,'app','m170228_171113_system_messages','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','92f908c8-9b0e-4467-ab19-4ecc2f6aab07'),
	(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','90987a99-a04a-4309-97d7-0fdf39535469'),
	(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','df592330-d749-4d63-8c8c-1f17348d5465'),
	(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','70a41cbc-443a-4255-8ff6-63dc1a52082f'),
	(56,NULL,'app','m170612_000000_route_index_shuffle','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','a21dbb09-3ff7-41e0-a327-e86d06251216'),
	(57,NULL,'app','m170621_195237_format_plugin_handles','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','89486757-b55e-4f35-b6cf-60593aa2037b'),
	(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','c6fa6a39-7d4f-4347-8728-389ae8d97aa3'),
	(59,NULL,'app','m170630_161028_deprecation_changes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','a7711eb9-939e-42b9-a281-e27f1826a899'),
	(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','cfd1c7a7-be4c-45a7-b0f1-04221c56c217'),
	(61,NULL,'app','m170704_134916_sites_tables','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','c1ba9cc7-1a56-4b4f-a49f-33c9b88efb16'),
	(62,NULL,'app','m170706_183216_rename_sequences','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','9a67c506-ac44-48f2-99c4-392bf1e0d6c4'),
	(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','7752ddf3-9348-449d-b209-758770223da4'),
	(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','03b6fc50-42d0-440d-8bc1-7814de4f305f'),
	(65,NULL,'app','m170810_201318_create_queue_table','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','d159c06e-3817-499e-9229-956da0223f4e'),
	(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','ea430cc3-6bea-4d64-81d7-ce64d113c455'),
	(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','aef1ec36-8e9a-42f5-abe0-ce085a01d4a3'),
	(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','448bc4e1-2d5d-463c-b024-290eae91b3aa'),
	(69,NULL,'app','m171011_214115_site_groups','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','c6ba5e88-d1d2-4da8-8ace-e0ca000676aa'),
	(70,NULL,'app','m171012_151440_primary_site','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','b18dbb39-2a03-41df-b6b7-09c3cdcb19ee'),
	(71,NULL,'app','m171013_142500_transform_interlace','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','6525ba4d-bc4d-4ee8-82d1-f793cf74a0ee'),
	(72,NULL,'app','m171016_092553_drop_position_select','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','f90e29c3-41f3-4536-a0b9-c03f9178b988'),
	(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','2faf8231-2f80-4613-8c1b-2165240de51d'),
	(74,NULL,'app','m171107_000000_assign_group_permissions','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','25a6dda4-2ac2-4cf6-b910-1d394ce5157e'),
	(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','88603373-9cf3-4f49-a959-e83f752c5621'),
	(76,NULL,'app','m171126_105927_disabled_plugins','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','b8b532c4-5dba-480e-ad5f-595e129ef977'),
	(77,NULL,'app','m171130_214407_craftidtokens_table','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','e47a86bb-660b-4386-84b4-95c14cd793d2'),
	(78,NULL,'app','m171202_004225_update_email_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','b6546799-694b-4c40-b528-eb9c6b62a6f3'),
	(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','b4c6aa16-d70f-40eb-ad21-ca892c2c67ac'),
	(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','c5c5242d-5b2e-466f-8de3-8a0ba90e0f5e'),
	(81,NULL,'app','m171218_143135_longtext_query_column','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','025355ef-b9c9-4563-8f73-117e461f4fec'),
	(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','6417daa0-878a-4908-906a-a4408748b47c'),
	(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','65408501-344d-4278-a493-1d7c4f00a5fc'),
	(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','c6fb2c40-e036-4b9b-936a-1b1eb57e451d'),
	(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','2a11afed-dec9-4a44-b8e3-b995568cbb37'),
	(86,NULL,'app','m180128_235202_set_tag_slugs','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','d5dad4f7-9bd7-49d7-9e9e-5019c6798bb4'),
	(87,NULL,'app','m180202_185551_fix_focal_points','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','502992d9-758f-4b47-a042-ea6dffb6d8fe'),
	(88,NULL,'app','m180217_172123_tiny_ints','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','75429d93-3c21-447e-80bd-11d00b8e1eaf'),
	(89,NULL,'app','m180321_233505_small_ints','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','de2b6deb-4664-4347-b44a-8a028a86a428'),
	(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','be2210e8-40bd-4d58-ac20-e79fd4d28716'),
	(91,NULL,'app','m180404_182320_edition_changes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','cbdf878c-23ea-4636-b419-06b6f3492f63'),
	(92,NULL,'app','m180411_102218_fix_db_routes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','b1d95bbd-b957-4211-b7a5-e7ed24b29cfd'),
	(93,NULL,'app','m180416_205628_resourcepaths_table','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','518b588c-fb7e-42e6-80cf-eb570a05e674'),
	(94,NULL,'app','m180418_205713_widget_cleanup','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','6ba6799b-4cf5-40c3-b669-e6f6e42281e0'),
	(95,NULL,'app','m180425_203349_searchable_fields','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','9488a98e-9e1d-41db-9b48-05cd6dfaaee4'),
	(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','a77c26e5-df40-40cb-9fca-fd2e3af9a966'),
	(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','047d7a46-8b5d-437b-a350-5ac5dfaae8ca'),
	(98,NULL,'app','m180518_173000_permissions_to_uid','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','453247c3-857d-4eda-b5e5-4d4f54cf1a9a'),
	(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','368828e2-edd5-44d5-aef1-aaf99d6ff3ce'),
	(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','b5817059-7b63-418c-8839-e4de5ffa1840'),
	(101,NULL,'app','m180731_162030_soft_delete_sites','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','72c37eb3-600b-40ad-b829-ad489ed9dc46'),
	(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','4d4108f1-c8ec-4e5b-b91e-caea361ce22b'),
	(103,NULL,'app','m180810_214439_soft_delete_elements','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','e6d77a39-8e5f-42c8-8f90-1d2093075f09'),
	(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','b2e15109-79d7-46bb-8cc6-a4a19f98f3c4'),
	(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','2a50ab7c-d802-4bb6-9afe-302cc162d234'),
	(106,NULL,'app','m180904_112109_permission_changes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','865142fd-eb22-4c18-ad52-9da271f2bbd2'),
	(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','b7ce28c3-0e75-4c47-8a81-ed67ff160339'),
	(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','4ea66781-6033-48fa-8b61-02c63d3b5c07'),
	(109,NULL,'app','m181016_183648_set_default_user_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','9c03af41-72bb-47d3-8891-f2e25c8a0d93'),
	(110,NULL,'app','m181017_225222_system_config_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','63da713d-a71e-4cce-8509-1e229e790c7f'),
	(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','2bba445e-1a3a-4fe9-8b42-7681798fd3b7'),
	(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','92f181f8-d9d3-43c4-abda-d8059d2688ff'),
	(113,NULL,'app','m181112_203955_sequences_table','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','3333458d-caa6-4c8f-9a81-3ac9372fb17a'),
	(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','1f497747-7cd0-4253-874b-5da260cebd35'),
	(115,NULL,'app','m181128_193942_fix_project_config','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','d6ba34a8-495c-416c-960b-56c3060c7670'),
	(116,NULL,'app','m181130_143040_fix_schema_version','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','35aceb4d-fbec-4d25-aec6-8f11ad695974'),
	(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','5bf66788-567b-470a-9635-a26361c5e0b3'),
	(118,NULL,'app','m181213_102500_config_map_aliases','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','66d74897-6f93-4056-9ed4-bd5e6cd61649'),
	(119,NULL,'app','m181217_153000_fix_structure_uids','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','beea37f0-626d-4774-a424-f3ba903cc3a6'),
	(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','50d91e1d-33e0-4f13-9e5a-e16b3ba39b26'),
	(121,NULL,'app','m190108_110000_cleanup_project_config','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','9879a8e4-61f1-4d69-b053-f067dfb79632'),
	(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','a57ca7b5-800a-4d7d-828e-f7f404c69aaf'),
	(123,NULL,'app','m190109_172845_fix_colspan','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','4ce4c050-1648-4850-8fc4-95582a48893e'),
	(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','aa97c948-d4ea-440a-aa5f-933cab42dda9'),
	(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','4dc9457c-7fb6-4531-b7e0-cb3bfed818f3'),
	(126,NULL,'app','m190112_124737_fix_user_settings','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','98b26e9f-d63a-4246-a0dd-0d1700ba49ba'),
	(127,NULL,'app','m190112_131225_fix_field_layouts','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','b3806272-3d95-4b49-b604-4fa95d4f7fe3'),
	(128,NULL,'app','m190112_201010_more_soft_deletes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','568e7a81-0aa1-403f-830e-e4f7afd910b1'),
	(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','dabd1674-416b-4687-a8ce-de496f9a3065'),
	(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','d2a56ae2-762e-4870-93df-f15d270f1d11'),
	(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','6b135455-cc5b-4820-852d-7f388e81b6ea'),
	(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','5a75bf82-08a6-4315-8513-3bed60348157'),
	(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','83aeef8e-509a-4a32-876d-709d0ec17141'),
	(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','95c0b236-23b7-4e1f-a5ff-020d1276f74f'),
	(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','85b95848-7e7e-4995-9678-454c52e55814'),
	(136,NULL,'app','m190312_152740_element_revisions','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','049f20c1-b400-49b6-8031-29eff9995f9a'),
	(137,NULL,'app','m190327_235137_propagation_method','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','8d262483-2b92-4ee0-918b-00bb3dbd68f3'),
	(138,NULL,'app','m190401_223843_drop_old_indexes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','537fae4a-23ed-4c33-9f91-c76117b10871'),
	(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','43cd23b4-75dd-4879-8a6d-c84b21d0ed3e'),
	(140,NULL,'app','m190417_085010_add_image_editor_permissions','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','820c0a2d-b10c-4ef2-b695-f1c92ecf8c05'),
	(141,NULL,'app','m190502_122019_store_default_user_group_uid','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','502874df-c39a-4f72-8faf-e59c1aabb586'),
	(142,NULL,'app','m190504_150349_preview_targets','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','0640a94a-c5cb-4b7d-a50a-3323e21b3131'),
	(143,NULL,'app','m190516_184711_job_progress_label','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','a14c8eb1-b6d7-43fc-baae-be9f8e60665b'),
	(144,NULL,'app','m190523_190303_optional_revision_creators','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','73f8ff92-5fb4-4e15-9cbe-ebce0d94726a'),
	(145,NULL,'app','m190529_204501_fix_duplicate_uids','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','6fb145af-ca48-4202-a555-eb1ccd8c23c6'),
	(146,NULL,'app','m190605_223807_unsaved_drafts','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','6e51de18-48c0-4866-aa72-e9021a13f850'),
	(147,NULL,'app','m190607_230042_entry_revision_error_tables','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','bbb68db9-db8c-4196-a556-40517639f5c4'),
	(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','49b6c82e-cff1-4c0f-893b-13fb3e21b97e'),
	(149,NULL,'app','m190617_164400_add_gqlschemas_table','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','972442d1-c7a7-4181-bbd3-636b67479ac8'),
	(150,NULL,'app','m190624_234204_matrix_propagation_method','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','058067fe-27cb-4a71-a834-f6bb1837077f'),
	(151,NULL,'app','m190711_153020_drop_snapshots','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','59a7b56c-04fb-4e71-a755-cc84ea742b78'),
	(152,NULL,'app','m190712_195914_no_draft_revisions','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','d0fc5d6d-d66b-456f-9762-994d7546709c'),
	(153,NULL,'app','m190723_140314_fix_preview_targets_column','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','2a454032-d75b-4585-a2dd-dab9ab4cf561'),
	(154,NULL,'app','m190820_003519_flush_compiled_templates','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','8a88a402-31ea-46d6-a595-30b5b00f2800'),
	(155,NULL,'app','m190823_020339_optional_draft_creators','2019-08-28 02:21:52','2019-08-28 02:21:52','2019-08-28 02:21:52','498a939b-f522-45af-819f-c736e40a8aa3'),
	(156,1,'plugin','m180430_204710_remove_old_plugins','2019-08-28 02:23:09','2019-08-28 02:23:09','2019-08-28 02:23:09','ede1334e-957d-447a-9934-e2ebbad2da03'),
	(157,1,'plugin','Install','2019-08-28 02:23:10','2019-08-28 02:23:10','2019-08-28 02:23:10','95f4331f-ad23-419c-b20a-cefb1b7663da'),
	(158,1,'plugin','m190225_003922_split_cleanup_html_settings','2019-08-28 02:23:10','2019-08-28 02:23:10','2019-08-28 02:23:10','3386a107-b0ed-4d08-a909-c3cf286c8b89');
ALTER TABLE `mod_migrations` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_queue` WRITE;
ALTER TABLE `mod_queue` DISABLE KEYS;
ALTER TABLE `mod_queue` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_relations` WRITE;
ALTER TABLE `mod_relations` DISABLE KEYS;
ALTER TABLE `mod_relations` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_resourcepaths` WRITE;
ALTER TABLE `mod_resourcepaths` DISABLE KEYS;
REPLACE INTO `mod_resourcepaths` (`hash`, `path`) VALUES 
	('1be52779','@craft/web/assets/recententries/dist'),
	('255f6517','@craft/web/assets/updateswidget/dist'),
	('3362dd45','@lib/xregexp'),
	('390e99cf','@lib/selectize'),
	('3f21bc86','@craft/web/assets/cp/dist'),
	('452e57a2','@lib/fabric'),
	('5068839c','@lib/garnishjs'),
	('63d5941a','@lib/d3'),
	('68528200','@lib/prismjs'),
	('6ad48889','@lib/jquery-touch-events'),
	('6d70b44b','@lib/picturefill'),
	('7598b5b5','@lib/fileupload'),
	('816f5755','@app/web/assets/login/dist'),
	('82f3931e','@craft/web/assets/craftsupport/dist'),
	('8551422b','@app/web/assets/cp/dist'),
	('8f035d2d','@vendor/craftcms/redactor/lib/redactor'),
	('bde6ae5a','@craft/web/assets/feed/dist'),
	('befce414','@lib/jquery-ui'),
	('c4a58891','@craft/web/assets/dashboard/dist'),
	('c9d8530','@lib/timepicker'),
	('ce4a2339','@lib/element-resize-detector'),
	('dad51332','@pennebaker/architect/assetbundles/indexcpsection/dist'),
	('e1da88cc','@bower/jquery/dist'),
	('e4034a91','@craft/web/assets/editentry/dist'),
	('e72a00ba','@app/web/assets/utilities/dist'),
	('ec72d059','@lib/jquery.payment'),
	('f0557fb1','@lib/velocity'),
	('f259c0ad','@craft/redactor/assets/field/dist');
ALTER TABLE `mod_resourcepaths` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_revisions` WRITE;
ALTER TABLE `mod_revisions` DISABLE KEYS;
ALTER TABLE `mod_revisions` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_searchindex` WRITE;
ALTER TABLE `mod_searchindex` DISABLE KEYS;
REPLACE INTO `mod_searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`) VALUES 
	(1,'username',0,1,' admin '),
	(1,'firstname',0,1,''),
	(1,'lastname',0,1,''),
	(1,'fullname',0,1,''),
	(1,'email',0,1,' selvin modcreativeinc com '),
	(1,'slug',0,1,'');
ALTER TABLE `mod_searchindex` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sections` WRITE;
ALTER TABLE `mod_sections` DISABLE KEYS;
REPLACE INTO `mod_sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagationMethod`, `previewTargets`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,1,'People','people','structure',0,'all',NULL,'2019-08-28 03:08:44','2019-08-28 03:08:44',NULL,'b796c1d1-b641-44ea-8128-02bc18f65fcc'),
	(2,2,'Places','places','structure',1,'all',NULL,'2019-08-28 03:08:45','2019-08-28 03:08:45',NULL,'2c0c1a7e-f890-4904-a132-cd347cc17da7');
ALTER TABLE `mod_sections` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sections_sites` WRITE;
ALTER TABLE `mod_sections_sites` DISABLE KEYS;
REPLACE INTO `mod_sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,0,NULL,NULL,0,'2019-08-28 03:08:45','2019-08-28 03:08:45','a61635d1-60e6-4792-ac9d-8c16b1aef16e'),
	(2,2,1,0,NULL,NULL,1,'2019-08-28 03:08:45','2019-08-28 03:08:45','2ba6a6c9-0155-4879-84ef-6f5a0f39b4de');
ALTER TABLE `mod_sections_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sequences` WRITE;
ALTER TABLE `mod_sequences` DISABLE KEYS;
ALTER TABLE `mod_sequences` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sessions` WRITE;
ALTER TABLE `mod_sessions` DISABLE KEYS;
REPLACE INTO `mod_sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,'1qcB7pcR_m-XMTEVG-z7EMJDXw-q0ZL4VVZKLKsqKJZIXZ9nbc3vq_1aRqpUv82OnMRkwaydP8Ya6JJF6wNy1ptQOQKnIZMSjBMw','2019-08-28 02:32:04','2019-08-28 04:11:02','f3fc412e-e578-46d7-9817-5f635f1046a8');
ALTER TABLE `mod_sessions` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_shunnedmessages` WRITE;
ALTER TABLE `mod_shunnedmessages` DISABLE KEYS;
ALTER TABLE `mod_shunnedmessages` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sitegroups` WRITE;
ALTER TABLE `mod_sitegroups` DISABLE KEYS;
REPLACE INTO `mod_sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,'ModCore','2019-08-28 02:21:47','2019-08-28 02:21:47',NULL,'505c19d2-64bf-4ead-a137-ee5848e9f3c3');
ALTER TABLE `mod_sitegroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sites` WRITE;
ALTER TABLE `mod_sites` DISABLE KEYS;
REPLACE INTO `mod_sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,1,1,'ModCore','default','en-US',1,'$DEFAULT_SITE_URL',1,'2019-08-28 02:21:47','2019-08-28 02:21:47',NULL,'86cb8f50-93a8-4e48-b08a-a74fc1941e97');
ALTER TABLE `mod_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_structures` WRITE;
ALTER TABLE `mod_structures` DISABLE KEYS;
REPLACE INTO `mod_structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,1,'2019-08-28 03:08:44','2019-08-28 03:08:44',NULL,'b2b34f31-0d3b-43d7-beed-468b1b3a10a6'),
	(2,5,'2019-08-28 03:08:45','2019-08-28 03:08:45',NULL,'9c6c0d8d-d006-41be-a487-7113b6241238'),
	(3,1,'2019-08-28 03:08:45','2019-08-28 03:08:45',NULL,'d055a3ea-72c4-4eca-8b57-9a5ca9d9e939');
ALTER TABLE `mod_structures` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_structureelements` WRITE;
ALTER TABLE `mod_structureelements` DISABLE KEYS;
REPLACE INTO `mod_structureelements` (`id`, `structureId`, `elementId`, `root`, `lft`, `rgt`, `level`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,2,NULL,1,1,4,0,'2019-08-28 03:09:55','2019-08-28 03:09:55','78f139c4-00db-4809-a4ad-93710af7795c'),
	(2,2,2,1,2,3,1,'2019-08-28 03:09:55','2019-08-28 03:09:55','1a0e61b0-f745-4694-9875-d8c5ecd532ef');
ALTER TABLE `mod_structureelements` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_systemmessages` WRITE;
ALTER TABLE `mod_systemmessages` DISABLE KEYS;
ALTER TABLE `mod_systemmessages` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_taggroups` WRITE;
ALTER TABLE `mod_taggroups` DISABLE KEYS;
ALTER TABLE `mod_taggroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_tags` WRITE;
ALTER TABLE `mod_tags` DISABLE KEYS;
ALTER TABLE `mod_tags` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_templatecaches` WRITE;
ALTER TABLE `mod_templatecaches` DISABLE KEYS;
ALTER TABLE `mod_templatecaches` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_templatecacheelements` WRITE;
ALTER TABLE `mod_templatecacheelements` DISABLE KEYS;
ALTER TABLE `mod_templatecacheelements` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_templatecachequeries` WRITE;
ALTER TABLE `mod_templatecachequeries` DISABLE KEYS;
ALTER TABLE `mod_templatecachequeries` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_tokens` WRITE;
ALTER TABLE `mod_tokens` DISABLE KEYS;
ALTER TABLE `mod_tokens` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_usergroups` WRITE;
ALTER TABLE `mod_usergroups` DISABLE KEYS;
ALTER TABLE `mod_usergroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_usergroups_users` WRITE;
ALTER TABLE `mod_usergroups_users` DISABLE KEYS;
ALTER TABLE `mod_usergroups_users` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_userpermissions` WRITE;
ALTER TABLE `mod_userpermissions` DISABLE KEYS;
ALTER TABLE `mod_userpermissions` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_userpermissions_usergroups` WRITE;
ALTER TABLE `mod_userpermissions_usergroups` DISABLE KEYS;
ALTER TABLE `mod_userpermissions_usergroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_users` WRITE;
ALTER TABLE `mod_users` DISABLE KEYS;
REPLACE INTO `mod_users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,'admin',NULL,NULL,NULL,'selvin@modcreativeinc.com','$2y$13$QzzRZg8BfdxYFBXa/gK8Yu4FlHkpgVJrvQaTmmz.BMxWj2Y11pf0m',1,0,0,0,'2019-08-28 02:32:04',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-08-28 02:21:50','2019-08-28 02:21:50','2019-08-28 03:08:36','46fa75a4-dcda-4c9a-8599-a2e00d875f28');
ALTER TABLE `mod_users` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_userpermissions_users` WRITE;
ALTER TABLE `mod_userpermissions_users` DISABLE KEYS;
ALTER TABLE `mod_userpermissions_users` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_userpreferences` WRITE;
ALTER TABLE `mod_userpreferences` DISABLE KEYS;
REPLACE INTO `mod_userpreferences` (`userId`, `preferences`) VALUES 
	(1,'{"language":"en-US"}');
ALTER TABLE `mod_userpreferences` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_volumes` WRITE;
ALTER TABLE `mod_volumes` DISABLE KEYS;
REPLACE INTO `mod_volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,NULL,'Uploads','uploads','craft\\volumes\\Local',1,'@web/uploads','{"path":"@webroot/uploads"}',1,'2019-08-28 03:08:45','2019-08-28 03:09:37',NULL,'06bbe7b5-3976-4c75-a2c7-a01ea0867363'),
	(2,NULL,'System','system','craft\\volumes\\Local',1,'@web/system','{"path":"@webroot/system"}',2,'2019-08-28 03:08:45','2019-08-28 03:09:38',NULL,'ee642d92-dde6-4de6-b53c-4537b3478500');
ALTER TABLE `mod_volumes` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_volumefolders` WRITE;
ALTER TABLE `mod_volumefolders` DISABLE KEYS;
REPLACE INTO `mod_volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,NULL,1,'Uploads','','2019-08-28 03:08:45','2019-08-28 03:09:38','a9944ac0-9675-41bd-a7e7-5592cd695cd3'),
	(2,NULL,2,'System','','2019-08-28 03:08:45','2019-08-28 03:09:38','0b310888-0c25-4f45-84d1-9ed657b22b5b'),
	(3,NULL,NULL,'Temporary source',NULL,'2019-08-28 03:09:55','2019-08-28 03:09:55','99136618-6637-44f1-9baa-d99bce02a4a3'),
	(4,3,NULL,'user_1','user_1/','2019-08-28 03:09:55','2019-08-28 03:09:55','428ea33e-183d-4516-a2f6-8ba8ddc6f2b2');
ALTER TABLE `mod_volumefolders` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_widgets` WRITE;
ALTER TABLE `mod_widgets` DISABLE KEYS;
REPLACE INTO `mod_widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,'craft\\widgets\\RecentEntries',1,NULL,'{"section":"*","siteId":"1","limit":10}',1,'2019-08-28 03:08:36','2019-08-28 03:08:36','0567f308-5e52-46ad-8f89-91f34ec24760'),
	(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-08-28 03:08:36','2019-08-28 03:08:36','81c80503-8af8-46fc-9364-075829674f2b'),
	(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-08-28 03:08:36','2019-08-28 03:08:36','49f8e42d-5a3a-447c-b57d-e48c117be2cb'),
	(4,1,'craft\\widgets\\Feed',4,NULL,'{"url":"https://craftcms.com/news.rss","title":"Craft News","limit":5}',1,'2019-08-28 03:08:36','2019-08-28 03:08:36','b6206bbb-f5d2-4c0e-81ab-e2811abc906c');
ALTER TABLE `mod_widgets` ENABLE KEYS;
UNLOCK TABLES;




SET FOREIGN_KEY_CHECKS = @PREVIOUS_FOREIGN_KEY_CHECKS;


