#
# SQL Export
# Created by Querious (201067)
# Created: August 9, 2019 at 10:53:15 PM CDT
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
DROP TABLE IF EXISTS `mod_globalsets`;
DROP TABLE IF EXISTS `mod_fieldlayoutfields`;
DROP TABLE IF EXISTS `mod_fields`;
DROP TABLE IF EXISTS `mod_fieldlayouttabs`;
DROP TABLE IF EXISTS `mod_fieldgroups`;
DROP TABLE IF EXISTS `mod_entries`;
DROP TABLE IF EXISTS `mod_entrytypes`;
DROP TABLE IF EXISTS `mod_fieldlayouts`;
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
  `field_personEmail` varchar(255) DEFAULT NULL,
  `field_personFirstName` text,
  `field_personLastName` text,
  `field_personPhone` text,
  `field_personDescription` text,
  `field_buildingName` text,
  `field_buildingDescription` text,
  `field_floorNumber` text,
  `field_floorId` text,
  `field_roomNumber` text,
  `field_roomId` text,
  `field_roomDescription` text,
  `field_campusName` text,
  `field_campusDescription` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `mod_content_siteId_idx` (`siteId`),
  KEY `mod_content_title_idx` (`title`),
  CONSTRAINT `mod_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `mod_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;


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
  `creatorId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `mod_drafts_creatorId_fk` (`creatorId`),
  KEY `mod_drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `mod_drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `mod_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;


CREATE TABLE `mod_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


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


CREATE TABLE `mod_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;


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
  CONSTRAINT `mod_revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `mod_users` (`id`) ON DELETE CASCADE,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;


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
	(1,1,NULL,'Departments','departments','2019-08-09 23:54:14','2019-08-09 23:54:14',NULL,'32a2dc05-2af1-4855-8252-4622cd2a8f56');
ALTER TABLE `mod_categorygroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_categories` WRITE;
ALTER TABLE `mod_categories` DISABLE KEYS;
REPLACE INTO `mod_categories` (`id`, `groupId`, `parentId`, `deletedWithGroup`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(2,1,NULL,NULL,'2019-08-10 00:01:40','2019-08-10 00:01:40','b4929aa9-9851-4583-94ea-34ddf1bdbe9b'),
	(3,1,NULL,NULL,'2019-08-10 00:02:05','2019-08-10 00:02:05','a6878e5d-09dd-4fe7-a7f1-1617fb1d3d92'),
	(4,1,NULL,NULL,'2019-08-10 00:02:13','2019-08-10 00:02:13','32dcda12-2ebc-4332-b0d3-446865d4ab76'),
	(5,1,NULL,NULL,'2019-08-10 00:02:27','2019-08-10 00:02:27','01e682f3-0001-4511-b70b-ce110aa2cb39');
ALTER TABLE `mod_categories` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_categorygroups_sites` WRITE;
ALTER TABLE `mod_categorygroups_sites` DISABLE KEYS;
REPLACE INTO `mod_categorygroups_sites` (`id`, `groupId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,1,'departments/{slug}','','2019-08-09 23:54:14','2019-08-09 23:54:14','cda1e34a-071c-4ccc-adc7-1f90958eecf9');
ALTER TABLE `mod_categorygroups_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_content` WRITE;
ALTER TABLE `mod_content` DISABLE KEYS;
REPLACE INTO `mod_content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_personEmail`, `field_personFirstName`, `field_personLastName`, `field_personPhone`, `field_personDescription`, `field_buildingName`, `field_buildingDescription`, `field_floorNumber`, `field_floorId`, `field_roomNumber`, `field_roomId`, `field_roomDescription`, `field_campusName`, `field_campusDescription`) VALUES 
	(1,1,1,NULL,'2019-08-06 14:20:26','2019-08-10 00:10:29','36067336-ac15-40c4-a74f-a4582312ed8d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,2,1,'Marketing','2019-08-10 00:01:39','2019-08-10 00:01:39','92699c86-749f-4d1a-85b7-1cc81e025ceb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,3,1,'Design','2019-08-10 00:02:04','2019-08-10 00:02:04','3c64afc6-e108-4200-bc43-cafc218a97f6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,4,1,'Development','2019-08-10 00:02:13','2019-08-10 00:02:13','06bcf1ab-8654-4eae-8297-ad4df3c601b8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,5,1,'Information Technology','2019-08-10 00:02:27','2019-08-10 00:02:27','793a10a5-65a1-4006-a8f8-045633982710',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,6,1,' ','2019-08-10 02:59:32','2019-08-10 02:59:32','8a7343c6-4d0d-49f0-9235-65183c1fb3ef',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(8,8,1,'Campus - Google Campus','2019-08-10 03:18:18','2019-08-10 03:32:57','7f457ea1-2a57-4d28-90ac-a6167ee39724',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Google Campus',NULL),
	(10,10,1,'Building - Search Innovation','2019-08-10 03:18:53','2019-08-10 03:31:15','5d918ae3-c251-4ac8-b4fd-1113bf501a21',NULL,NULL,NULL,NULL,NULL,'Search Innovation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(12,12,1,'Building - Google Glass','2019-08-10 03:19:16','2019-08-10 03:31:20','8522fe33-91aa-413c-9a3a-95a404cb41b1',NULL,NULL,NULL,NULL,NULL,'Google Glass',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(14,14,1,'Floor 1','2019-08-10 03:20:20','2019-08-10 03:37:56','90afbc4f-4c56-4bdc-87b9-eae975e75747',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','GGF1',NULL,NULL,NULL,NULL,NULL),
	(15,15,1,'Floor 2','2019-08-10 03:20:34','2019-08-10 03:37:37','6a797743-33ed-4614-87c0-a7f7e159d56b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2','GGF2',NULL,NULL,NULL,NULL,NULL),
	(17,17,1,'Floor 1','2019-08-10 03:22:03','2019-08-10 03:38:49','725c3a33-5f02-4e15-802d-94b73a4ca0b8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','SIF1',NULL,NULL,NULL,NULL,NULL),
	(18,18,1,'Floor 2','2019-08-10 03:22:37','2019-08-10 03:39:11','f7eb7e9a-523b-423b-80eb-20b8d705d200',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2','SIF2',NULL,NULL,NULL,NULL,NULL),
	(20,20,1,'Room G201','2019-08-10 03:26:30','2019-08-10 03:35:07','1f09a57f-902f-44aa-b1b0-c7885a439d1e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'G201','B60F2RG201',NULL,NULL,NULL),
	(21,21,1,'Campus - ','2019-08-10 03:26:41','2019-08-10 03:26:41','ac852912-e0bf-47e8-8a1d-2d9bbfc1f4ba',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(22,22,1,'Room G209','2019-08-10 03:26:49','2019-08-10 03:35:19','fa3d2acd-335a-4daf-a584-b71ae76ffdce',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'G209','B60F2RG209',NULL,NULL,NULL),
	(23,23,1,'Room G103','2019-08-10 03:28:10','2019-08-10 03:33:15','59e7e538-ae2f-47d1-a4b0-030357a2ab4b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'G103','B60F1RG103',NULL,NULL,NULL),
	(24,24,1,'Room G106','2019-08-10 03:28:10','2019-08-10 03:33:33','2f247495-9343-4c91-9acf-749a78e2faa4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'G106','B60F1RG106',NULL,NULL,NULL),
	(25,25,1,'Campus - Apple Campus','2019-08-10 03:31:35','2019-08-10 03:31:53','bace899f-4b1c-4706-a500-85d592d506e6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Apple Campus',NULL),
	(26,26,1,'Building - Design and Engineering','2019-08-10 03:31:35','2019-08-10 03:32:18','8149f133-a14a-40d1-a834-b6bb4b3a5477',NULL,NULL,NULL,NULL,NULL,'Design and Engineering',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(27,27,1,'Floor 1','2019-08-10 03:31:35','2019-08-10 03:39:52','e68ec8cc-255e-4f43-bec7-69811b2aeb28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','DEF1',NULL,NULL,NULL,NULL,NULL),
	(28,28,1,'Room C103','2019-08-10 03:31:35','2019-08-10 03:31:35','c40ce3ba-d9ac-4212-8b54-d644b5dc3ebc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'C103','B60F1RC103',NULL,NULL,NULL),
	(29,29,1,'Room C106','2019-08-10 03:31:35','2019-08-10 03:31:35','3157ebac-d503-4864-971f-5c62500fabab',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'C106','B60F1RC106',NULL,NULL,NULL),
	(30,30,1,'Floor 2','2019-08-10 03:31:35','2019-08-10 03:31:35','f5071c96-e146-40c0-8cec-04643fe169f0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2','B60F2',NULL,NULL,NULL,NULL,NULL),
	(31,31,1,'Room X201','2019-08-10 03:31:35','2019-08-10 03:31:35','321a8b50-e85b-4707-98ac-2db783802ad1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'X201','B60F2RX201',NULL,NULL,NULL),
	(32,32,1,'Room X209','2019-08-10 03:31:35','2019-08-10 03:31:35','4179a406-3ab3-477a-afb5-b0963e2a5300',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'X209','B60F2RX209',NULL,NULL,NULL),
	(33,33,1,'Building - Keyboard Lab','2019-08-10 03:31:35','2019-08-10 03:32:43','1ec4dcfd-ae61-41e6-aeba-4339f481764e',NULL,NULL,NULL,NULL,NULL,'Keyboard Lab',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(34,34,1,'Floor 1','2019-08-10 03:31:35','2019-08-10 03:31:35','39c3c073-9e7d-4671-b08e-47a3bbcdafdb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','B12155F1',NULL,NULL,NULL,NULL,NULL),
	(35,35,1,'Floor 2','2019-08-10 03:31:35','2019-08-10 03:31:35','04f9103c-d880-4b4c-8b6a-c3994d344597',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2','B12155F2',NULL,NULL,NULL,NULL,NULL),
	(37,48,1,'Selvin Ortiz','2019-08-10 03:44:39','2019-08-10 03:44:39','ca2442be-5a32-49c2-8ec4-565fc1e49f43','selvin@modcreativeinc.com','Selvin','Ortiz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(39,66,1,'Phil Nelson','2019-08-10 03:45:52','2019-08-10 03:45:52','c136d571-bd47-4159-a02b-847604b5eafa','phil@modcreativeinc.com','Phil','Nelson',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
	(1,NULL,1,'First draft',NULL),
	(8,NULL,1,'First draft',NULL);
ALTER TABLE `mod_drafts` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_elementindexsettings` WRITE;
ALTER TABLE `mod_elementindexsettings` DISABLE KEYS;
REPLACE INTO `mod_elementindexsettings` (`id`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,'craft\\elements\\Entry','{"sources":{"section:55acf63b-b2c2-454b-9842-fdecf05be856":{"tableAttributes":{"1":"field:25","2":"field:28","3":"field:24"}},"section:84c2ec09-b2d9-4812-addd-abc792357963":{"tableAttributes":{"1":"field:39","2":"field:30","3":"field:32","4":"field:36"}}}}','2019-08-10 03:16:45','2019-08-10 03:16:45','199eff6c-148a-45f2-9a53-8e03bc68ca61');
ALTER TABLE `mod_elementindexsettings` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_elements` WRITE;
ALTER TABLE `mod_elements` DISABLE KEYS;
REPLACE INTO `mod_elements` (`id`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2019-08-06 14:20:25','2019-08-10 00:10:28',NULL,'09d16a69-77d3-44ee-99c5-4376ccdc035e'),
	(2,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-10 00:01:39','2019-08-10 00:01:39',NULL,'6773627c-02b1-4b68-9d7e-f8fcd3ffeb20'),
	(3,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-10 00:02:04','2019-08-10 00:02:04',NULL,'b5cc260f-bbd5-46ed-b02e-c88f19ad0a9b'),
	(4,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-10 00:02:13','2019-08-10 00:02:13',NULL,'a5257512-9480-414c-865f-ed7a51981cf0'),
	(5,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-10 00:02:27','2019-08-10 00:02:27',NULL,'68bf4db0-a42c-4c3f-bd25-9b22da1dc61d'),
	(6,1,NULL,3,'craft\\elements\\Entry',1,0,'2019-08-10 02:59:32','2019-08-10 02:59:32',NULL,'14396a06-4d4d-46af-89f4-b0d4cf699f90'),
	(8,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2019-08-10 03:17:49','2019-08-10 03:32:57',NULL,'037f1729-8477-4547-859c-6a3f372b295c'),
	(10,NULL,NULL,5,'craft\\elements\\Entry',1,0,'2019-08-10 03:18:27','2019-08-10 03:31:15',NULL,'66b97519-78de-41fd-b2b1-40f7a6b6d3f8'),
	(12,NULL,NULL,5,'craft\\elements\\Entry',1,0,'2019-08-10 03:19:01','2019-08-10 03:31:20',NULL,'7abbc3ab-befa-445a-b64b-1cded3ddb216'),
	(14,NULL,NULL,6,'craft\\elements\\Entry',1,0,'2019-08-10 03:19:38','2019-08-10 03:37:56',NULL,'f302c99d-6867-45b4-8afb-3621735c5071'),
	(15,NULL,NULL,6,'craft\\elements\\Entry',1,0,'2019-08-10 03:19:38','2019-08-10 03:37:37',NULL,'a542e5e7-fbf0-4a4a-ad8b-0806860c1beb'),
	(17,NULL,NULL,6,'craft\\elements\\Entry',1,0,'2019-08-10 03:21:39','2019-08-10 03:38:49',NULL,'f273b862-9ccb-4d36-82e1-7a4c6e9f6c80'),
	(18,NULL,NULL,6,'craft\\elements\\Entry',1,0,'2019-08-10 03:21:39','2019-08-10 03:39:11',NULL,'15d17989-ccf6-4b07-8f30-54da7b7bcd4c'),
	(20,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2019-08-10 03:25:47','2019-08-10 03:35:07',NULL,'22d94e00-b2d9-4086-b597-79fbaa1928b7'),
	(21,8,NULL,4,'craft\\elements\\Entry',1,0,'2019-08-10 03:26:41','2019-08-10 03:26:41',NULL,'593b1e93-dea8-4211-992e-02fac0b539dd'),
	(22,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2019-08-10 03:25:47','2019-08-10 03:35:19',NULL,'47cbe163-435c-4f86-aace-736518004462'),
	(23,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2019-08-10 03:25:47','2019-08-10 03:33:15',NULL,'288883d8-b720-4b59-a8c4-73e56d25dfcc'),
	(24,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2019-08-10 03:25:47','2019-08-10 03:33:33',NULL,'b90746d6-736e-4e05-b0c9-58c24ce96604'),
	(25,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2019-08-10 03:17:49','2019-08-10 03:31:53',NULL,'0dc015a6-9450-4131-8e81-a6d35e4792a4'),
	(26,NULL,NULL,5,'craft\\elements\\Entry',1,0,'2019-08-10 03:19:01','2019-08-10 03:32:18',NULL,'caf2b089-fc44-4033-822b-3badc2d154a0'),
	(27,NULL,NULL,6,'craft\\elements\\Entry',1,0,'2019-08-10 03:19:38','2019-08-10 03:39:52',NULL,'54b2317b-9273-470d-a257-c935b5204b9a'),
	(28,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2019-08-10 03:25:47','2019-08-10 03:26:30',NULL,'c180ddf0-f652-49a7-9bad-f28e2df1c4f1'),
	(29,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2019-08-10 03:25:47','2019-08-10 03:28:01',NULL,'daf82352-eeb6-41bb-b8ac-b7664a9350c4'),
	(30,NULL,NULL,6,'craft\\elements\\Entry',1,0,'2019-08-10 03:19:38','2019-08-10 03:20:46',NULL,'e910fc31-539e-4ed6-b25f-b929dbb6e8a9'),
	(31,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2019-08-10 03:25:47','2019-08-10 03:28:55',NULL,'75413efa-cea4-42e0-bb3a-76a7b06c74a9'),
	(32,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2019-08-10 03:25:47','2019-08-10 03:29:22',NULL,'fc83c475-7961-4173-90e3-d40016a156a0'),
	(33,NULL,NULL,5,'craft\\elements\\Entry',1,0,'2019-08-10 03:18:27','2019-08-10 03:32:43',NULL,'dafd0bc0-1287-4d8f-a82e-374dbfc0c9e2'),
	(34,NULL,NULL,6,'craft\\elements\\Entry',1,0,'2019-08-10 03:21:39','2019-08-10 03:22:03',NULL,'cf7d3676-c81b-41f5-8999-f689e5c94d24'),
	(35,NULL,NULL,6,'craft\\elements\\Entry',1,0,'2019-08-10 03:21:39','2019-08-10 03:22:46',NULL,'f196fed9-f82c-4e06-b4bf-818cb01005d0'),
	(37,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:44:12','2019-08-10 03:44:12','2019-08-10 03:44:19','0312fcf2-d23f-45f7-8fbe-cf8260b7fc00'),
	(38,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:44:19','2019-08-10 03:44:19','2019-08-10 03:44:25','f825b1b5-264f-4439-ba60-8fa970b681f4'),
	(39,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:44:25','2019-08-10 03:44:25','2019-08-10 03:44:27','ee6ae286-e91b-4ae6-aa33-709569566e75'),
	(40,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:44:27','2019-08-10 03:44:27','2019-08-10 03:44:32','29959e38-1b24-40c8-b75b-576cb4601329'),
	(41,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:44:27','2019-08-10 03:44:27','2019-08-10 03:44:32','e667ba93-4300-443f-8118-0e0a711364ef'),
	(42,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:44:32','2019-08-10 03:44:32','2019-08-10 03:44:38','70a5a516-eeb1-478f-9f4f-663684a7ac24'),
	(43,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:44:32','2019-08-10 03:44:32','2019-08-10 03:44:38','1649ce74-91fd-4013-826f-042d50d4fee4'),
	(44,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:44:38','2019-08-10 03:44:38','2019-08-10 03:44:39','2e340494-4ca2-4aa4-b2d6-2189953de0e6'),
	(45,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:44:38','2019-08-10 03:44:38','2019-08-10 03:44:39','15871606-d1cc-42d9-847a-0ea16bff7a1e'),
	(48,NULL,NULL,3,'craft\\elements\\Entry',1,0,'2019-08-10 03:43:35','2019-08-10 03:44:39',NULL,'cfe09ceb-fdef-460f-8ac6-e3e3dffad3e1'),
	(49,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:44:39','2019-08-10 03:44:39',NULL,'35fa7e5e-fbd4-4b62-95c7-c9da3c26f1bc'),
	(50,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:44:39','2019-08-10 03:44:39',NULL,'f376a006-efe3-401f-8829-d541576f4dbd'),
	(52,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:19','2019-08-10 03:45:19','2019-08-10 03:45:27','c65f3eef-3a15-4d31-bfa7-2aed6ed0037e'),
	(53,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:27','2019-08-10 03:45:27','2019-08-10 03:45:33','e06d6316-4efb-4d98-9cd8-3a26d7eeecef'),
	(54,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:33','2019-08-10 03:45:33','2019-08-10 03:45:35','d0ccc7dc-445c-45c1-ae43-16009553be79'),
	(55,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:35','2019-08-10 03:45:35','2019-08-10 03:45:38','730cdae1-14a1-43ba-8a1f-96a9d60df75c'),
	(56,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:38','2019-08-10 03:45:38','2019-08-10 03:45:44','c6474709-ba1d-42b7-b108-5c2393ef12e6'),
	(57,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:38','2019-08-10 03:45:38','2019-08-10 03:45:44','13b73464-1110-48a2-9233-3123aa60c6ae'),
	(58,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:44','2019-08-10 03:45:44','2019-08-10 03:45:49','2200d5b7-911e-4eb8-876d-1934cbcb6cd3'),
	(59,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:44','2019-08-10 03:45:44','2019-08-10 03:45:49','25fe94ba-a5a9-4ab7-9c18-c9d0dd10b07b'),
	(60,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:49','2019-08-10 03:45:49','2019-08-10 03:45:50','7ac6345a-8a8d-4690-ab5a-35b2c1693fed'),
	(61,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:49','2019-08-10 03:45:49','2019-08-10 03:45:50','3f7c5a89-fd9c-46d7-8459-402aa7f19ce7'),
	(62,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:50','2019-08-10 03:45:50','2019-08-10 03:45:52','02372691-4a6f-4b16-814a-764fa5bf2a71'),
	(63,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:50','2019-08-10 03:45:50','2019-08-10 03:45:52','c3f94804-0a1c-4633-aaf8-5695ee042e34'),
	(66,NULL,NULL,3,'craft\\elements\\Entry',1,0,'2019-08-10 03:44:45','2019-08-10 03:45:52',NULL,'1d80583f-ef3d-46f5-88d4-3856bf1554ef'),
	(67,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:52','2019-08-10 03:45:52',NULL,'5b7132b5-d0aa-4df2-9816-5ce9995f7b37'),
	(68,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2019-08-10 03:45:52','2019-08-10 03:45:52',NULL,'bad97af4-9f40-40ef-b5df-075065d77376');
ALTER TABLE `mod_elements` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_elements_sites` WRITE;
ALTER TABLE `mod_elements_sites` DISABLE KEYS;
REPLACE INTO `mod_elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,NULL,NULL,1,'2019-08-06 14:20:26','2019-08-06 14:20:26','40db421f-54e1-4799-a4ee-b5c3f57e46e4'),
	(2,2,1,'marketing','departments/marketing',1,'2019-08-10 00:01:39','2019-08-10 00:01:48','31bc7be4-0d18-4726-8774-aa946ea49f58'),
	(3,3,1,'design','departments/design',1,'2019-08-10 00:02:04','2019-08-10 00:02:32','821b2bac-2fa0-4718-9b49-af26c6364ee8'),
	(4,4,1,'development','departments/development',1,'2019-08-10 00:02:13','2019-08-10 00:02:14','2209a95d-010e-4c4e-8ab2-aa5c09018d51'),
	(5,5,1,'information-technology','departments/information-technology',1,'2019-08-10 00:02:27','2019-08-10 00:02:27','dfbbf558-73fd-410a-ade9-f98244633847'),
	(6,6,1,'__temp_hzpsDjFzSauPss4OjCDidmc5I4htivByUFM9','people/__temp_hzpsDjFzSauPss4OjCDidmc5I4htivByUFM9',1,'2019-08-10 02:59:32','2019-08-10 02:59:32','16d88b53-4b92-44a2-a68b-b4f6b736d556'),
	(8,8,1,'campus-google-campus','places/campus-google-campus',1,'2019-08-10 03:18:18','2019-08-10 03:32:57','f914d149-ca7a-487b-a7ac-78af0d4d3400'),
	(10,10,1,'building-search-innovation','places/campus-google-campus/building-search-innovation',1,'2019-08-10 03:18:53','2019-08-10 03:32:58','c62f15ae-46e0-457f-8213-b6335201d403'),
	(12,12,1,'building-google-glass','places/campus-google-campus/building-google-glass',1,'2019-08-10 03:19:16','2019-08-10 03:32:57','8d0d629c-d4b7-4c9c-b4cc-a6df07ec0efb'),
	(14,14,1,'floor-1','places/campus-google-campus/building-google-glass/floor-1',1,'2019-08-10 03:20:20','2019-08-10 03:37:56','5e5b7b05-4e10-4681-9bce-145b56bc3ee5'),
	(15,15,1,'floor-2','places/campus-google-campus/building-google-glass/floor-2',1,'2019-08-10 03:20:34','2019-08-10 03:37:37','64db2b86-2aed-4d7f-9333-923d4cd38010'),
	(17,17,1,'floor-1','places/campus-google-campus/building-search-innovation/floor-1',1,'2019-08-10 03:22:03','2019-08-10 03:38:49','0a48af4a-992a-4cd6-8255-d35c375717ae'),
	(18,18,1,'floor-2','places/campus-google-campus/building-search-innovation/floor-2',1,'2019-08-10 03:22:37','2019-08-10 03:39:11','3fed942d-ce80-47a3-b079-5c5d9d74217b'),
	(20,20,1,'room-g201','places/campus-google-campus/building-google-glass/floor-2/room-g201',1,'2019-08-10 03:26:30','2019-08-10 03:37:38','d333f3bd-c4d0-4bbe-b9ea-664cf7e12f00'),
	(21,21,1,'__temp_u3YHKP3g1B5cf5BIgwyTtHlBKphVJ4mi4fsq','places/blaine/building-60/b60f1/b60f1rc103/__temp_u3YHKP3g1B5cf5BIgwyTtHlBKphVJ4mi4fsq',1,'2019-08-10 03:26:41','2019-08-10 03:26:41','04a555f9-55b0-4134-b09e-7f5c67d0ee51'),
	(22,22,1,'room-g209','places/campus-google-campus/building-google-glass/floor-2/room-g209',1,'2019-08-10 03:26:49','2019-08-10 03:37:38','233cc330-a35e-4eb4-bd64-f928524902a0'),
	(23,23,1,'room-g103','places/campus-google-campus/building-google-glass/floor-1/room-g103',1,'2019-08-10 03:28:10','2019-08-10 03:37:56','6d56b087-6acc-4df3-9210-33376ad7ea65'),
	(24,24,1,'room-g106','places/campus-google-campus/building-google-glass/floor-1/room-g106',1,'2019-08-10 03:28:10','2019-08-10 03:37:56','6d055802-1694-447f-b6a9-604a81bf242d'),
	(25,25,1,'campus-apple-campus','places/campus-apple-campus',1,'2019-08-10 03:31:35','2019-08-10 03:31:53','2eba4932-a38c-4192-a27a-a3d5a4947083'),
	(26,26,1,'building-design-and-engineering','places/campus-apple-campus/building-design-and-engineering',1,'2019-08-10 03:31:35','2019-08-10 03:32:18','ee0d2d1a-d8a2-4123-ad0b-949231209a04'),
	(27,27,1,'floor-1','places/campus-apple-campus/building-design-and-engineering/floor-1',1,'2019-08-10 03:31:35','2019-08-10 03:39:52','cb60658f-a8c3-47ed-a271-fde347cc4f10'),
	(28,28,1,'b60f1rc103-1-1','places/campus-apple-campus/building-design-and-engineering/floor-1/b60f1rc103-1-1',1,'2019-08-10 03:31:35','2019-08-10 03:39:53','d54761ba-bd62-4114-83c3-75003bdfc9a1'),
	(29,29,1,'b60f1rc106-1-1','places/campus-apple-campus/building-design-and-engineering/floor-1/b60f1rc106-1-1',1,'2019-08-10 03:31:35','2019-08-10 03:39:53','0e2b859a-4e0c-4588-af2d-13fdeaecb7f6'),
	(30,30,1,'b60f2-1','places/campus-apple-campus/building-design-and-engineering/b60f2-1',1,'2019-08-10 03:31:35','2019-08-10 03:32:19','541bd134-745b-4b3b-885f-df58212c8084'),
	(31,31,1,'room-x201-1','places/campus-apple-campus/building-design-and-engineering/b60f2-1/room-x201-1',1,'2019-08-10 03:31:35','2019-08-10 03:32:19','04b32393-a6db-4f99-bde4-eb24950db489'),
	(32,32,1,'room-x209-1','places/campus-apple-campus/building-design-and-engineering/b60f2-1/room-x209-1',1,'2019-08-10 03:31:35','2019-08-10 03:32:19','12c9885d-e885-490a-a441-2f116680b7d2'),
	(33,33,1,'building-keyboard-lab','places/campus-apple-campus/building-keyboard-lab',1,'2019-08-10 03:31:35','2019-08-10 03:32:43','8f630f5f-9022-40da-899b-740f89f1a2c0'),
	(34,34,1,'b12155f1-1','places/campus-apple-campus/building-keyboard-lab/b12155f1-1',1,'2019-08-10 03:31:35','2019-08-10 03:32:43','786b0e9d-9230-456b-9c09-e7b0de72d1e9'),
	(35,35,1,'b12155f2-1','places/campus-apple-campus/building-keyboard-lab/b12155f2-1',1,'2019-08-10 03:31:35','2019-08-10 03:32:43','58230f0a-0471-4ada-9698-fba981b3ee77'),
	(37,37,1,NULL,NULL,1,'2019-08-10 03:44:12','2019-08-10 03:44:12','4c49d6cc-2535-4ae3-b051-e21dbf1cf27b'),
	(38,38,1,NULL,NULL,1,'2019-08-10 03:44:19','2019-08-10 03:44:19','bc2e893e-902b-496a-bd44-e099648d152f'),
	(39,39,1,NULL,NULL,1,'2019-08-10 03:44:25','2019-08-10 03:44:25','b983da3a-6859-47d6-b122-427d52379ba0'),
	(40,40,1,NULL,NULL,1,'2019-08-10 03:44:27','2019-08-10 03:44:27','930dacbf-cb39-404c-ad0a-264fde48a46a'),
	(41,41,1,NULL,NULL,1,'2019-08-10 03:44:27','2019-08-10 03:44:27','86f42f59-9b83-4e41-95de-4576476ed40e'),
	(42,42,1,NULL,NULL,1,'2019-08-10 03:44:32','2019-08-10 03:44:32','227d2662-27b8-4c61-acd3-03b6767e659b'),
	(43,43,1,NULL,NULL,1,'2019-08-10 03:44:32','2019-08-10 03:44:32','a18fc938-c75c-4ad0-a22b-4db3a516cb3f'),
	(44,44,1,NULL,NULL,1,'2019-08-10 03:44:38','2019-08-10 03:44:38','8ecc8c07-8cc3-42ac-8eb7-e422da13c4b3'),
	(45,45,1,NULL,NULL,1,'2019-08-10 03:44:38','2019-08-10 03:44:38','2dd9db99-6f6d-428a-8b34-8128b8fca985'),
	(48,48,1,'selvin-ortiz','people/selvin-ortiz',1,'2019-08-10 03:44:39','2019-08-10 03:44:40','365643f5-6896-4669-aa72-e51ea3fe25b8'),
	(49,49,1,NULL,NULL,1,'2019-08-10 03:44:39','2019-08-10 03:44:39','d9f6db54-d1c8-49b6-8c31-c761f5481082'),
	(50,50,1,NULL,NULL,1,'2019-08-10 03:44:39','2019-08-10 03:44:39','975c1875-b037-4494-9f5b-e2660ae81743'),
	(52,52,1,NULL,NULL,1,'2019-08-10 03:45:19','2019-08-10 03:45:19','778ebc7d-8a68-440a-bd08-1c9ec6f2f629'),
	(53,53,1,NULL,NULL,1,'2019-08-10 03:45:27','2019-08-10 03:45:27','f96b9f9d-8201-4b30-804f-fd598a87e8de'),
	(54,54,1,NULL,NULL,1,'2019-08-10 03:45:33','2019-08-10 03:45:33','430c8823-40bd-4657-981f-1cc2994cbfdd'),
	(55,55,1,NULL,NULL,1,'2019-08-10 03:45:35','2019-08-10 03:45:35','8e2ba0ae-b2b2-48f0-886e-daf620f99814'),
	(56,56,1,NULL,NULL,1,'2019-08-10 03:45:38','2019-08-10 03:45:38','6ade57c2-d8c4-48ef-b395-f24bfb7a1265'),
	(57,57,1,NULL,NULL,1,'2019-08-10 03:45:38','2019-08-10 03:45:38','72ebf220-2ff2-43eb-bf07-7bf49fec293b'),
	(58,58,1,NULL,NULL,1,'2019-08-10 03:45:44','2019-08-10 03:45:44','1b7907e5-a26e-41cd-b9f1-57bf742039fe'),
	(59,59,1,NULL,NULL,1,'2019-08-10 03:45:44','2019-08-10 03:45:44','01cfddb7-d6e1-4a5a-918b-eb3745d18931'),
	(60,60,1,NULL,NULL,1,'2019-08-10 03:45:49','2019-08-10 03:45:49','3be87525-7464-4fec-a115-423b9ee2a414'),
	(61,61,1,NULL,NULL,1,'2019-08-10 03:45:49','2019-08-10 03:45:49','b7e47596-90dc-4489-a5c0-03824e0e3f04'),
	(62,62,1,NULL,NULL,1,'2019-08-10 03:45:50','2019-08-10 03:45:50','3183fbfb-5bf4-485a-b9f6-27b6a61169ac'),
	(63,63,1,NULL,NULL,1,'2019-08-10 03:45:50','2019-08-10 03:45:50','7e6c4bb5-7611-4ce9-80a4-1985891877b5'),
	(66,66,1,'phil-nelson','people/phil-nelson',1,'2019-08-10 03:45:52','2019-08-10 03:45:52','0616b58a-a88a-4a09-b329-bd657a4fdb2e'),
	(67,67,1,NULL,NULL,1,'2019-08-10 03:45:52','2019-08-10 03:45:52','9a2b4e76-f116-45f2-bddd-bbf917121e14'),
	(68,68,1,NULL,NULL,1,'2019-08-10 03:45:52','2019-08-10 03:45:52','a0168ae2-b94b-43f1-b071-dbdf0728b9fd');
ALTER TABLE `mod_elements_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldlayouts` WRITE;
ALTER TABLE `mod_fieldlayouts` DISABLE KEYS;
REPLACE INTO `mod_fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,'craft\\elements\\MatrixBlock','2019-08-09 23:44:41','2019-08-09 23:44:41','2019-08-09 23:49:33','b0f6608f-9d59-44ff-984f-b5b93bb4c776'),
	(2,'craft\\elements\\MatrixBlock','2019-08-10 02:44:28','2019-08-10 02:44:28',NULL,'96260623-cc76-48a1-8145-a03c15871ac0'),
	(3,'craft\\elements\\Entry','2019-08-10 02:57:34','2019-08-10 02:57:34',NULL,'08c355ce-9ea1-4d9e-bf3f-a34190cb898e'),
	(4,'craft\\elements\\Entry','2019-08-10 03:12:45','2019-08-10 03:12:45',NULL,'976dc8ec-4d2c-494f-95bf-6e4efb5a09c0'),
	(5,'craft\\elements\\Entry','2019-08-10 03:13:26','2019-08-10 03:13:26',NULL,'dc848041-d51c-48b7-aa97-3889eac4e387'),
	(6,'craft\\elements\\Entry','2019-08-10 03:14:33','2019-08-10 03:14:33',NULL,'43ac5f06-24db-486b-96b9-94d114e9890c'),
	(7,'craft\\elements\\Entry','2019-08-10 03:15:37','2019-08-10 03:15:37',NULL,'8cd08abc-cdd4-4dbd-94a9-d2ffc17c71e1');
ALTER TABLE `mod_fieldlayouts` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_entrytypes` WRITE;
ALTER TABLE `mod_entrytypes` DISABLE KEYS;
REPLACE INTO `mod_entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,1,3,'People','people',0,'Title','{personFirstName} {personLastName}',1,'2019-08-09 23:56:27','2019-08-10 02:57:35',NULL,'768985c8-5d07-4ad1-a7a3-ab74f182d220'),
	(2,2,4,'Campus','campus',0,'Name','Campus - {campusName}',1,'2019-08-09 23:57:22','2019-08-10 03:25:10',NULL,'f541d666-e7e1-45b5-a776-7bbdfa66e29c'),
	(3,2,5,'Building','building',0,'Name','Building - {buildingName}',2,'2019-08-09 23:59:04','2019-08-10 03:24:56',NULL,'f6e43059-9031-4777-a162-591a7fee0760'),
	(4,2,6,'Floor','floor',0,'Number','Floor {floorNumber}',3,'2019-08-09 23:59:48','2019-08-10 03:23:57',NULL,'99871494-af8f-4f42-bdb0-3e519fedf271'),
	(5,2,7,'Room','room',0,'Number','Room {roomNumber}',4,'2019-08-10 00:00:09','2019-08-10 03:27:29',NULL,'8c221645-84c1-4d99-b523-c089ef81a347');
ALTER TABLE `mod_entrytypes` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_entries` WRITE;
ALTER TABLE `mod_entries` DISABLE KEYS;
REPLACE INTO `mod_entries` (`id`, `sectionId`, `parentId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `deletedWithEntryType`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(6,1,NULL,1,1,'2019-08-10 02:59:00',NULL,NULL,'2019-08-10 02:59:33','2019-08-10 02:59:33','ae0b8f1c-93a4-4126-bc0a-50fc66c6ad03'),
	(8,2,NULL,2,1,'2019-08-10 03:17:00',NULL,NULL,'2019-08-10 03:18:18','2019-08-10 03:18:18','c69cd967-6bc4-43e3-8ba2-5da30f40a29c'),
	(10,2,NULL,3,1,'2019-08-10 03:18:00',NULL,NULL,'2019-08-10 03:18:53','2019-08-10 03:18:53','6c346525-fcfb-4e59-a8a3-e35b684bb245'),
	(12,2,NULL,3,1,'2019-08-10 03:19:00',NULL,NULL,'2019-08-10 03:19:16','2019-08-10 03:19:16','b15f5f67-3f78-434c-b70f-ec88fe7e074a'),
	(14,2,NULL,4,1,'2019-08-10 03:19:00',NULL,NULL,'2019-08-10 03:20:20','2019-08-10 03:20:20','e0e7e291-5afb-408a-bf8a-f345805648fa'),
	(15,2,NULL,4,1,'2019-08-10 03:19:00',NULL,NULL,'2019-08-10 03:20:34','2019-08-10 03:20:34','6438e33e-f3b7-4ea3-ae74-4c7c8f013e2c'),
	(17,2,NULL,4,1,'2019-08-10 03:21:00',NULL,NULL,'2019-08-10 03:22:03','2019-08-10 03:22:03','147b76e1-6d06-48bc-bbba-2932d94db090'),
	(18,2,NULL,4,1,'2019-08-10 03:21:00',NULL,NULL,'2019-08-10 03:22:37','2019-08-10 03:22:37','aca9d841-787b-47e8-b3fc-8aefd86f091b'),
	(20,2,NULL,5,1,'2019-08-10 03:25:00',NULL,NULL,'2019-08-10 03:26:30','2019-08-10 03:26:30','57f17417-5b77-425b-8b5c-d1a8330be28b'),
	(21,2,NULL,2,1,'2019-08-10 03:26:00',NULL,NULL,'2019-08-10 03:26:41','2019-08-10 03:26:41','5963a657-8d7d-40f5-8a26-df3a66d341f0'),
	(22,2,NULL,5,1,'2019-08-10 03:25:00',NULL,NULL,'2019-08-10 03:26:49','2019-08-10 03:26:49','ed163070-bd0b-4f8c-8e40-4f318a743e41'),
	(23,2,NULL,5,1,'2019-08-10 03:25:00',NULL,NULL,'2019-08-10 03:28:10','2019-08-10 03:28:10','2a510b74-be8f-498f-9fe9-38a0fba4903b'),
	(24,2,NULL,5,1,'2019-08-10 03:25:00',NULL,NULL,'2019-08-10 03:28:10','2019-08-10 03:28:10','824babab-873a-404a-86ec-ebc81a22041c'),
	(25,2,NULL,2,1,'2019-08-10 03:17:00',NULL,NULL,'2019-08-10 03:31:35','2019-08-10 03:31:35','3132bdf8-76e3-4bcc-9cc2-fd956e66814d'),
	(26,2,NULL,3,1,'2019-08-10 03:19:00',NULL,NULL,'2019-08-10 03:31:35','2019-08-10 03:31:35','1da8b154-bfd6-4e4c-9f43-ce192c47caaa'),
	(27,2,NULL,4,1,'2019-08-10 03:19:00',NULL,NULL,'2019-08-10 03:31:35','2019-08-10 03:31:35','e03c2921-07a8-417f-9bcd-1ae5927a56b5'),
	(28,2,NULL,5,1,'2019-08-10 03:25:00',NULL,NULL,'2019-08-10 03:31:35','2019-08-10 03:31:35','87969aaf-d028-41ca-a12c-b17f26c16780'),
	(29,2,NULL,5,1,'2019-08-10 03:25:00',NULL,NULL,'2019-08-10 03:31:35','2019-08-10 03:31:35','a8006b40-57af-4bd1-95c3-106a1ca22517'),
	(30,2,NULL,4,1,'2019-08-10 03:19:00',NULL,NULL,'2019-08-10 03:31:35','2019-08-10 03:31:35','125f1eff-2221-4ad3-a41b-57a6577ff181'),
	(31,2,NULL,5,1,'2019-08-10 03:25:00',NULL,NULL,'2019-08-10 03:31:35','2019-08-10 03:31:35','82394173-cf42-4001-ac14-501f9201c86f'),
	(32,2,NULL,5,1,'2019-08-10 03:25:00',NULL,NULL,'2019-08-10 03:31:35','2019-08-10 03:31:35','0b0e02f7-93e3-42fb-84ae-8f7e1f31801a'),
	(33,2,NULL,3,1,'2019-08-10 03:18:00',NULL,NULL,'2019-08-10 03:31:35','2019-08-10 03:31:35','8b52b0fc-5521-4914-806a-36c88d61c571'),
	(34,2,NULL,4,1,'2019-08-10 03:21:00',NULL,NULL,'2019-08-10 03:31:35','2019-08-10 03:31:35','a57ea34e-ce7d-4dea-9c55-c1f5db411db8'),
	(35,2,NULL,4,1,'2019-08-10 03:21:00',NULL,NULL,'2019-08-10 03:31:35','2019-08-10 03:31:35','c11bd667-56e8-4df8-9896-0d7e7a5e83de'),
	(48,1,NULL,1,1,'2019-08-10 03:43:00',NULL,NULL,'2019-08-10 03:44:39','2019-08-10 03:44:39','8743d8e9-de07-454a-a5f9-7401e6611267'),
	(66,1,NULL,1,1,'2019-08-10 03:44:00',NULL,NULL,'2019-08-10 03:45:52','2019-08-10 03:45:52','e70a5b22-5bd4-4843-b08b-3300749b0751');
ALTER TABLE `mod_entries` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldgroups` WRITE;
ALTER TABLE `mod_fieldgroups` DISABLE KEYS;
REPLACE INTO `mod_fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(4,'Place','2019-08-10 02:39:31','2019-08-10 02:39:31','d51319aa-d183-4d62-a10f-85b774991265'),
	(5,'Person','2019-08-10 02:46:29','2019-08-10 02:46:29','8abcec74-950f-4c2c-826f-90ec9d431344');
ALTER TABLE `mod_fieldgroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldlayouttabs` WRITE;
ALTER TABLE `mod_fieldlayouttabs` DISABLE KEYS;
REPLACE INTO `mod_fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,'Content',1,'2019-08-09 23:44:42','2019-08-09 23:44:42','c5a68ed3-807f-4cf6-a77c-3f9fb33ab533'),
	(4,3,'Person',1,'2019-08-10 02:57:34','2019-08-10 02:57:34','989df71a-f729-4e6f-89b8-cccdf6bd1309'),
	(5,3,'Related',2,'2019-08-10 02:57:35','2019-08-10 02:57:35','d5237814-a493-4eab-820d-3496e4aaef8e'),
	(11,6,'Floor',1,'2019-08-10 03:23:57','2019-08-10 03:23:57','6f264bce-a69e-48f4-aec3-125040ae0649'),
	(12,6,'System',2,'2019-08-10 03:23:57','2019-08-10 03:23:57','eb855a49-a04c-4a36-8885-8c3263fe5d6f'),
	(15,5,'Building',1,'2019-08-10 03:24:56','2019-08-10 03:24:56','77e4c35e-dd28-4c65-8892-2e14a395376a'),
	(16,4,'Campus',1,'2019-08-10 03:25:10','2019-08-10 03:25:10','faf8561b-c032-4a40-a855-d998ea0f8375'),
	(17,7,'Room',1,'2019-08-10 03:27:29','2019-08-10 03:27:29','0d946e16-229e-46cf-b2a2-9e21cb0f4df7'),
	(18,7,'System',2,'2019-08-10 03:27:29','2019-08-10 03:27:29','f55f6bc7-1022-4aa7-8896-7c23ec275469'),
	(19,2,'Content',1,'2019-08-10 03:46:56','2019-08-10 03:46:56','438a9691-2a49-49f9-9287-0c89ea25b395');
ALTER TABLE `mod_fieldlayouttabs` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fields` WRITE;
ALTER TABLE `mod_fields` DISABLE KEYS;
REPLACE INTO `mod_fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `searchable`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(21,5,'Person Roles','personRoles','global','',0,'site',NULL,'craft\\fields\\Matrix','{"minBlocks":"","maxBlocks":"","contentTable":"{{%matrixcontent_personroles}}","propagationMethod":"all"}','2019-08-10 02:44:25','2019-08-10 03:46:54','66a17cc2-957d-483f-8d65-51372f52a23e'),
	(22,NULL,'Department','roleDepartment','matrixBlockType:3b4f98d9-c1ae-4a72-906e-22d0b76e34e8','',0,'site',NULL,'craft\\fields\\Categories','{"allowLimit":false,"allowMultipleSources":false,"branchLimit":"1","sources":"*","source":"group:32a2dc05-2af1-4855-8252-4622cd2a8f56","targetSiteId":null,"viewMode":null,"limit":null,"selectionLabel":"Add department","localizeRelations":false,"validateRelatedElements":""}','2019-08-10 02:44:26','2019-08-10 03:46:54','6251e539-858b-4b79-a9a1-666d0ec9e6a5'),
	(23,NULL,'Title','roleTitle','matrixBlockType:3b4f98d9-c1ae-4a72-906e-22d0b76e34e8','',0,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-10 02:44:27','2019-08-10 03:46:55','ba154e40-1f8a-450a-a3fb-9cff8bf55279'),
	(24,5,'Person Related Place','personRelatedPlace','global','',1,'site',NULL,'craft\\fields\\Entries','{"sources":["section:84c2ec09-b2d9-4812-addd-abc792357963"],"source":null,"targetSiteId":null,"viewMode":null,"limit":"1","selectionLabel":"Add related place","localizeRelations":false,"validateRelatedElements":""}','2019-08-10 02:45:47','2019-08-10 02:46:59','0eac1edf-d2b7-41fc-ac76-90e33e0f05fe'),
	(25,5,'Person Email','personEmail','global','',1,'none',NULL,'craft\\fields\\Email','{"placeholder":""}','2019-08-10 02:46:17','2019-08-10 02:46:39','bd97fa74-9f0b-46f1-a1ea-1567cf8f4635'),
	(26,5,'Person First Name','personFirstName','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-10 02:48:27','2019-08-10 02:48:27','eb28711a-c08f-4574-8f4c-b3d6238b7461'),
	(27,5,'Person Last Name','personLastName','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-10 02:48:46','2019-08-10 02:48:46','b58c7a00-0c30-4bde-b4ad-4931937a7b45'),
	(28,5,'Person Phone','personPhone','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-10 02:50:23','2019-08-10 02:50:23','44b73424-c5cb-4d78-bf30-d1ca79e8ba31'),
	(29,5,'Person Description','personDescription','global','A short bio or profile summary about this person',1,'none',NULL,'craft\\redactor\\Field','{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"}','2019-08-10 02:52:58','2019-08-10 02:52:58','6814ba50-1a8f-4a77-9123-d9e8512e8027'),
	(30,4,'Building Name','buildingName','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-10 03:01:11','2019-08-10 03:01:11','39976630-3751-447b-bd85-0731fac009a0'),
	(31,4,'Building Description','buildingDescription','global','',1,'none',NULL,'craft\\redactor\\Field','{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"}','2019-08-10 03:02:11','2019-08-10 03:02:11','6cda667e-fee7-4fd7-8f0e-e32b1b2612c9'),
	(32,4,'Floor Number','floorNumber','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-10 03:03:52','2019-08-10 03:03:52','366533dd-f4af-4a3f-9fdc-a3ded38bdf54'),
	(33,4,'Floor ID','floorId','global','For internal use only',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-10 03:04:33','2019-08-10 03:04:33','f2b88e66-3a40-4271-a5e5-88ab8b3ddcf6'),
	(34,4,'Floor Map','floorMap','global','',1,'site',NULL,'craft\\fields\\Assets','{"useSingleFolder":"","defaultUploadLocationSource":"volume:8d7880f3-e3e2-409a-866e-6aa2b3a0f616","defaultUploadLocationSubpath":"maps/{floorId}","singleUploadLocationSource":"volume:8d7880f3-e3e2-409a-866e-6aa2b3a0f616","singleUploadLocationSubpath":"","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add floor map","localizeRelations":false,"validateRelatedElements":""}','2019-08-10 03:08:25','2019-08-10 03:08:25','f0263ee6-18cd-4f2c-b68b-57f52901a5bb'),
	(36,4,'Room Number','roomNumber','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-10 03:09:39','2019-08-10 03:09:39','48188c5e-9c0a-4875-a5b9-d1a672bce6b4'),
	(37,4,'Room ID','roomId','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-10 03:09:53','2019-08-10 03:09:53','1b873abe-b2e3-4526-bb3f-5d1e969615a9'),
	(38,4,'Room Description','roomDescription','global','',1,'none',NULL,'craft\\redactor\\Field','{"redactorConfig":"","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"}','2019-08-10 03:10:29','2019-08-10 03:10:29','752e32fa-e188-4bd9-a63b-2f7b1ddec8f4'),
	(39,4,'Campus Name','campusName','global','',1,'none',NULL,'craft\\fields\\PlainText','{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"}','2019-08-10 03:10:56','2019-08-10 03:10:56','36e26123-2f4c-4f36-9bcd-ae7bae2f1f82'),
	(40,4,'Campus Description','campusDescription','global','',1,'none',NULL,'craft\\redactor\\Field','{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"}','2019-08-10 03:11:18','2019-08-10 03:11:30','471ca8b0-779e-4fdb-960f-25b1f550cc60');
ALTER TABLE `mod_fields` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldlayoutfields` WRITE;
ALTER TABLE `mod_fieldlayoutfields` DISABLE KEYS;
REPLACE INTO `mod_fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(7,3,4,28,0,4,'2019-08-10 02:57:35','2019-08-10 02:57:35','f5c14e35-ef67-4432-bd16-a5a705d475a0'),
	(8,3,4,21,0,6,'2019-08-10 02:57:35','2019-08-10 02:57:35','936d925b-a80e-476f-8fd0-e55be318fb96'),
	(9,3,4,29,0,5,'2019-08-10 02:57:35','2019-08-10 02:57:35','3613d005-c00d-4fad-ba7d-d321082ce8d8'),
	(10,3,4,27,1,2,'2019-08-10 02:57:35','2019-08-10 02:57:35','345d0ba3-760b-47f0-be93-2ba41d934c95'),
	(11,3,4,25,1,3,'2019-08-10 02:57:35','2019-08-10 02:57:35','40304f1b-9b61-46fe-b1ad-b375643593b7'),
	(12,3,4,26,1,1,'2019-08-10 02:57:35','2019-08-10 02:57:35','c1910503-ab91-494a-bcc6-badaa68b3b23'),
	(13,3,5,24,0,1,'2019-08-10 02:57:35','2019-08-10 02:57:35','f2780dc8-20b4-4dc1-ac47-827bb5aedc59'),
	(28,6,11,32,1,1,'2019-08-10 03:23:57','2019-08-10 03:23:57','666fab30-f2e9-4326-8a8f-c20edb41b7cc'),
	(29,6,11,34,0,2,'2019-08-10 03:23:57','2019-08-10 03:23:57','156f7695-438c-49ca-973b-c609f2cfdcc1'),
	(30,6,12,33,0,1,'2019-08-10 03:23:57','2019-08-10 03:23:57','5fd9c419-0819-4c2c-9b8e-cd95c08756e3'),
	(34,5,15,30,1,1,'2019-08-10 03:24:56','2019-08-10 03:24:56','1a12f883-9b92-4200-acf5-a0840b0b20c4'),
	(35,5,15,31,0,2,'2019-08-10 03:24:56','2019-08-10 03:24:56','2a63c02f-b225-435e-85fd-b7b1c3286e66'),
	(36,4,16,39,1,1,'2019-08-10 03:25:10','2019-08-10 03:25:10','39fe5eb2-e74f-4cbc-9b0d-9f08100ae1ad'),
	(37,4,16,40,0,2,'2019-08-10 03:25:10','2019-08-10 03:25:10','2032e052-7982-4b38-a226-701362a663f3'),
	(38,7,17,36,1,1,'2019-08-10 03:27:29','2019-08-10 03:27:29','18fbadaa-eeac-4de4-9c90-36d4209ed1d5'),
	(39,7,17,38,0,2,'2019-08-10 03:27:29','2019-08-10 03:27:29','2f22806a-0177-4833-b9eb-fbcaf4121fa5'),
	(40,7,18,37,0,1,'2019-08-10 03:27:29','2019-08-10 03:27:29','431d926a-4252-4bf4-bd8d-645ecacc472a'),
	(41,2,19,22,1,2,'2019-08-10 03:46:56','2019-08-10 03:46:56','aaa898e9-f4ca-419e-837d-228f4a6c34b2'),
	(42,2,19,23,1,1,'2019-08-10 03:46:56','2019-08-10 03:46:56','32e4bfde-29c4-4407-8dea-650b8ba73dfe');
ALTER TABLE `mod_fieldlayoutfields` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_globalsets` WRITE;
ALTER TABLE `mod_globalsets` DISABLE KEYS;
ALTER TABLE `mod_globalsets` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_info` WRITE;
ALTER TABLE `mod_info` DISABLE KEYS;
REPLACE INTO `mod_info` (`id`, `version`, `schemaVersion`, `maintenance`, `config`, `configMap`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,'3.2.9','3.2.16',0,'{"fieldGroups":{"d51319aa-d183-4d62-a10f-85b774991265":{"name":"Place"},"8abcec74-950f-4c2c-826f-90ec9d431344":{"name":"Person"}},"siteGroups":{"ff79c85e-c1a7-4b70-b7f9-8d73726d5506":{"name":"ModCore"}},"sites":{"c1732a15-3da9-4623-9804-bb1538425f67":{"baseUrl":"$DEFAULT_SITE_URL","handle":"default","hasUrls":true,"language":"en-US","name":"ModCore","primary":true,"siteGroup":"ff79c85e-c1a7-4b70-b7f9-8d73726d5506","sortOrder":1}},"email":{"fromEmail":"selvin@modcreativeinc.com","fromName":"Mod Creative","template":"","transportType":"craft\\\\mail\\\\transportadapters\\\\Sendmail","transportSettings":null},"system":{"edition":"pro","name":"ModCore","live":true,"schemaVersion":"3.2.16","timeZone":"America/Chicago"},"users":{"requireEmailVerification":true,"allowPublicRegistration":false,"defaultGroup":null,"photoVolumeUid":null,"photoSubpath":""},"dateModified":1565408814,"plugins":{"redactor":{"edition":"standard","enabled":true,"schemaVersion":"2.3.0"}},"fields":{"66a17cc2-957d-483f-8d65-51372f52a23e":{"name":"Person Roles","handle":"personRoles","instructions":"","searchable":false,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Matrix","settings":{"minBlocks":"","maxBlocks":"","contentTable":"{{%matrixcontent_personroles}}","propagationMethod":"all"},"contentColumnType":"string","fieldGroup":"8abcec74-950f-4c2c-826f-90ec9d431344"},"0eac1edf-d2b7-41fc-ac76-90e33e0f05fe":{"name":"Person Related Place","handle":"personRelatedPlace","instructions":"","searchable":true,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Entries","settings":{"sources":["section:84c2ec09-b2d9-4812-addd-abc792357963"],"source":null,"targetSiteId":null,"viewMode":null,"limit":"1","selectionLabel":"Add related place","localizeRelations":false,"validateRelatedElements":""},"contentColumnType":"string","fieldGroup":"8abcec74-950f-4c2c-826f-90ec9d431344"},"bd97fa74-9f0b-46f1-a1ea-1567cf8f4635":{"name":"Person Email","handle":"personEmail","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\Email","settings":{"placeholder":""},"contentColumnType":"string","fieldGroup":"8abcec74-950f-4c2c-826f-90ec9d431344"},"eb28711a-c08f-4574-8f4c-b3d6238b7461":{"name":"Person First Name","handle":"personFirstName","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"8abcec74-950f-4c2c-826f-90ec9d431344"},"b58c7a00-0c30-4bde-b4ad-4931937a7b45":{"name":"Person Last Name","handle":"personLastName","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"8abcec74-950f-4c2c-826f-90ec9d431344"},"44b73424-c5cb-4d78-bf30-d1ca79e8ba31":{"name":"Person Phone","handle":"personPhone","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"8abcec74-950f-4c2c-826f-90ec9d431344"},"6814ba50-1a8f-4a77-9123-d9e8512e8027":{"name":"Person Description","handle":"personDescription","instructions":"A short bio or profile summary about this person","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\redactor\\\\Field","settings":{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"},"contentColumnType":"text","fieldGroup":"8abcec74-950f-4c2c-826f-90ec9d431344"},"39976630-3751-447b-bd85-0731fac009a0":{"name":"Building Name","handle":"buildingName","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"d51319aa-d183-4d62-a10f-85b774991265"},"6cda667e-fee7-4fd7-8f0e-e32b1b2612c9":{"name":"Building Description","handle":"buildingDescription","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\redactor\\\\Field","settings":{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"},"contentColumnType":"text","fieldGroup":"d51319aa-d183-4d62-a10f-85b774991265"},"366533dd-f4af-4a3f-9fdc-a3ded38bdf54":{"name":"Floor Number","handle":"floorNumber","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"d51319aa-d183-4d62-a10f-85b774991265"},"f2b88e66-3a40-4271-a5e5-88ab8b3ddcf6":{"name":"Floor ID","handle":"floorId","instructions":"For internal use only","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"d51319aa-d183-4d62-a10f-85b774991265"},"f0263ee6-18cd-4f2c-b68b-57f52901a5bb":{"name":"Floor Map","handle":"floorMap","instructions":"","searchable":true,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Assets","settings":{"useSingleFolder":"","defaultUploadLocationSource":"volume:8d7880f3-e3e2-409a-866e-6aa2b3a0f616","defaultUploadLocationSubpath":"maps/{floorId}","singleUploadLocationSource":"volume:8d7880f3-e3e2-409a-866e-6aa2b3a0f616","singleUploadLocationSubpath":"","restrictFiles":"1","allowedKinds":["image"],"sources":"*","source":null,"targetSiteId":null,"viewMode":"large","limit":"1","selectionLabel":"Add floor map","localizeRelations":false,"validateRelatedElements":""},"contentColumnType":"string","fieldGroup":"d51319aa-d183-4d62-a10f-85b774991265"},"48188c5e-9c0a-4875-a5b9-d1a672bce6b4":{"name":"Room Number","handle":"roomNumber","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"d51319aa-d183-4d62-a10f-85b774991265"},"1b873abe-b2e3-4526-bb3f-5d1e969615a9":{"name":"Room ID","handle":"roomId","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"d51319aa-d183-4d62-a10f-85b774991265"},"752e32fa-e188-4bd9-a63b-2f7b1ddec8f4":{"name":"Room Description","handle":"roomDescription","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\redactor\\\\Field","settings":{"redactorConfig":"","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"},"contentColumnType":"text","fieldGroup":"d51319aa-d183-4d62-a10f-85b774991265"},"36e26123-2f4c-4f36-9bcd-ae7bae2f1f82":{"name":"Campus Name","handle":"campusName","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":"d51319aa-d183-4d62-a10f-85b774991265"},"471ca8b0-779e-4fdb-960f-25b1f550cc60":{"name":"Campus Description","handle":"campusDescription","instructions":"","searchable":true,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\redactor\\\\Field","settings":{"redactorConfig":"Simple.json","purifierConfig":"","cleanupHtml":true,"removeInlineStyles":"1","removeEmptyTags":"1","removeNbsp":"1","purifyHtml":"1","columnType":"text","availableVolumes":"","availableTransforms":"*"},"contentColumnType":"text","fieldGroup":"d51319aa-d183-4d62-a10f-85b774991265"}},"matrixBlockTypes":{"3b4f98d9-c1ae-4a72-906e-22d0b76e34e8":{"field":"66a17cc2-957d-483f-8d65-51372f52a23e","name":"Role","handle":"role","sortOrder":1,"fields":{"6251e539-858b-4b79-a9a1-666d0ec9e6a5":{"name":"Department","handle":"roleDepartment","instructions":"","searchable":false,"translationMethod":"site","translationKeyFormat":null,"type":"craft\\\\fields\\\\Categories","settings":{"allowLimit":false,"allowMultipleSources":false,"branchLimit":"1","sources":"*","source":"group:32a2dc05-2af1-4855-8252-4622cd2a8f56","targetSiteId":null,"viewMode":null,"limit":null,"selectionLabel":"Add department","localizeRelations":false,"validateRelatedElements":""},"contentColumnType":"string","fieldGroup":null},"ba154e40-1f8a-450a-a3fb-9cff8bf55279":{"name":"Title","handle":"roleTitle","instructions":"","searchable":false,"translationMethod":"none","translationKeyFormat":null,"type":"craft\\\\fields\\\\PlainText","settings":{"placeholder":"","code":"","multiline":"","initialRows":"4","charLimit":"","columnType":"text"},"contentColumnType":"text","fieldGroup":null}},"fieldLayouts":{"96260623-cc76-48a1-8145-a03c15871ac0":{"tabs":[{"name":"Content","sortOrder":1,"fields":{"6251e539-858b-4b79-a9a1-666d0ec9e6a5":{"required":true,"sortOrder":2},"ba154e40-1f8a-450a-a3fb-9cff8bf55279":{"required":true,"sortOrder":1}}}]}}}},"categoryGroups":{"32a2dc05-2af1-4855-8252-4622cd2a8f56":{"name":"Departments","handle":"departments","structure":{"uid":"d6205b4f-1b8a-4afe-a3f5-728fac8df0e7","maxLevels":1},"siteSettings":{"c1732a15-3da9-4623-9804-bb1538425f67":{"hasUrls":true,"uriFormat":"departments/{slug}","template":""}}}},"sections":{"55acf63b-b2c2-454b-9842-fdecf05be856":{"name":"People","handle":"people","type":"structure","enableVersioning":false,"propagationMethod":"all","siteSettings":{"c1732a15-3da9-4623-9804-bb1538425f67":{"enabledByDefault":true,"hasUrls":true,"uriFormat":"people/{slug}","template":"people/_person"}},"structure":{"uid":"99a5afbe-485a-4886-8da1-2070ffec24b6","maxLevels":1},"entryTypes":{"768985c8-5d07-4ad1-a7a3-ab74f182d220":{"name":"People","handle":"people","hasTitleField":false,"titleLabel":"Title","titleFormat":"{personFirstName} {personLastName}","sortOrder":1,"fieldLayouts":{"08c355ce-9ea1-4d9e-bf3f-a34190cb898e":{"tabs":[{"name":"Person","sortOrder":1,"fields":{"44b73424-c5cb-4d78-bf30-d1ca79e8ba31":{"required":false,"sortOrder":4},"66a17cc2-957d-483f-8d65-51372f52a23e":{"required":false,"sortOrder":6},"6814ba50-1a8f-4a77-9123-d9e8512e8027":{"required":false,"sortOrder":5},"b58c7a00-0c30-4bde-b4ad-4931937a7b45":{"required":true,"sortOrder":2},"bd97fa74-9f0b-46f1-a1ea-1567cf8f4635":{"required":true,"sortOrder":3},"eb28711a-c08f-4574-8f4c-b3d6238b7461":{"required":true,"sortOrder":1}}},{"name":"Related","sortOrder":2,"fields":{"0eac1edf-d2b7-41fc-ac76-90e33e0f05fe":{"required":false,"sortOrder":1}}}]}}}}},"84c2ec09-b2d9-4812-addd-abc792357963":{"name":"Places","handle":"places","type":"structure","enableVersioning":false,"propagationMethod":"all","siteSettings":{"c1732a15-3da9-4623-9804-bb1538425f67":{"enabledByDefault":true,"hasUrls":true,"uriFormat":"{parent.uri ?? \'places\'}/{slug}","template":"places/_place"}},"structure":{"uid":"eee91aaf-9337-42be-81fa-195c750c1a64","maxLevels":5},"entryTypes":{"f541d666-e7e1-45b5-a776-7bbdfa66e29c":{"name":"Campus","handle":"campus","hasTitleField":false,"titleLabel":"Name","titleFormat":"Campus - {campusName}","sortOrder":1,"fieldLayouts":{"976dc8ec-4d2c-494f-95bf-6e4efb5a09c0":{"tabs":[{"name":"Campus","sortOrder":1,"fields":{"36e26123-2f4c-4f36-9bcd-ae7bae2f1f82":{"required":true,"sortOrder":1},"471ca8b0-779e-4fdb-960f-25b1f550cc60":{"required":false,"sortOrder":2}}}]}}},"f6e43059-9031-4777-a162-591a7fee0760":{"name":"Building","handle":"building","hasTitleField":false,"titleLabel":"Name","titleFormat":"Building - {buildingName}","sortOrder":2,"fieldLayouts":{"dc848041-d51c-48b7-aa97-3889eac4e387":{"tabs":[{"name":"Building","sortOrder":1,"fields":{"39976630-3751-447b-bd85-0731fac009a0":{"required":true,"sortOrder":1},"6cda667e-fee7-4fd7-8f0e-e32b1b2612c9":{"required":false,"sortOrder":2}}}]}}},"99871494-af8f-4f42-bdb0-3e519fedf271":{"name":"Floor","handle":"floor","hasTitleField":false,"titleLabel":"Number","titleFormat":"Floor {floorNumber}","sortOrder":3,"fieldLayouts":{"43ac5f06-24db-486b-96b9-94d114e9890c":{"tabs":[{"name":"Floor","sortOrder":1,"fields":{"366533dd-f4af-4a3f-9fdc-a3ded38bdf54":{"required":true,"sortOrder":1},"f0263ee6-18cd-4f2c-b68b-57f52901a5bb":{"required":false,"sortOrder":2}}},{"name":"System","sortOrder":2,"fields":{"f2b88e66-3a40-4271-a5e5-88ab8b3ddcf6":{"required":false,"sortOrder":1}}}]}}},"8c221645-84c1-4d99-b523-c089ef81a347":{"name":"Room","handle":"room","hasTitleField":false,"titleLabel":"Number","titleFormat":"Room {roomNumber}","sortOrder":4,"fieldLayouts":{"8cd08abc-cdd4-4dbd-94a9-d2ffc17c71e1":{"tabs":[{"name":"Room","sortOrder":1,"fields":{"48188c5e-9c0a-4875-a5b9-d1a672bce6b4":{"required":true,"sortOrder":1},"752e32fa-e188-4bd9-a63b-2f7b1ddec8f4":{"required":false,"sortOrder":2}}},{"name":"System","sortOrder":2,"fields":{"1b873abe-b2e3-4526-bb3f-5d1e969615a9":{"required":false,"sortOrder":1}}}]}}}}}},"volumes":{"8d7880f3-e3e2-409a-866e-6aa2b3a0f616":{"name":"Uploads","handle":"uploads","type":"craft\\\\volumes\\\\Local","hasUrls":true,"url":"@web/uploads","settings":{"path":"@webroot/uploads"},"sortOrder":1},"9b3e91a4-dbdb-4640-9d8e-028f11cfc6ed":{"name":"System","handle":"system","type":"craft\\\\volumes\\\\Local","hasUrls":true,"url":"@web/system","settings":{"path":"@webroot/system"},"sortOrder":2}}}','[]','Ph5MXGtmjWrC','2019-08-06 14:20:22','2019-08-06 14:20:22','5dd55b49-beeb-41cf-a1b6-0eab9e39f954');
ALTER TABLE `mod_info` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_matrixblocktypes` WRITE;
ALTER TABLE `mod_matrixblocktypes` DISABLE KEYS;
REPLACE INTO `mod_matrixblocktypes` (`id`, `fieldId`, `fieldLayoutId`, `name`, `handle`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(2,21,2,'Role','role',1,'2019-08-10 02:44:28','2019-08-10 02:44:28','3b4f98d9-c1ae-4a72-906e-22d0b76e34e8');
ALTER TABLE `mod_matrixblocktypes` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_matrixblocks` WRITE;
ALTER TABLE `mod_matrixblocks` DISABLE KEYS;
REPLACE INTO `mod_matrixblocks` (`id`, `ownerId`, `fieldId`, `typeId`, `sortOrder`, `deletedWithOwner`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(49,48,21,2,1,NULL,'2019-08-10 03:44:39','2019-08-10 03:44:39','2e7a9bd0-7523-4a28-a750-e9a77f994c9d'),
	(50,48,21,2,2,NULL,'2019-08-10 03:44:39','2019-08-10 03:44:39','3e73619a-b08b-4de0-9c2f-366a8272070b'),
	(67,66,21,2,1,NULL,'2019-08-10 03:45:52','2019-08-10 03:45:52','8ab1a466-6916-4226-b686-fb400e1193da'),
	(68,66,21,2,2,NULL,'2019-08-10 03:45:52','2019-08-10 03:45:52','f0f0de74-92d1-460f-a632-1530e08c1d4d');
ALTER TABLE `mod_matrixblocks` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_matrixcontent_personroles` WRITE;
ALTER TABLE `mod_matrixcontent_personroles` DISABLE KEYS;
REPLACE INTO `mod_matrixcontent_personroles` (`id`, `elementId`, `siteId`, `dateCreated`, `dateUpdated`, `uid`, `field_role_roleTitle`) VALUES 
	(1,37,1,'2019-08-10 03:44:12','2019-08-10 03:44:12','74e71b30-7bcf-4b03-b15f-f0e1aa0cd263',NULL),
	(2,38,1,'2019-08-10 03:44:19','2019-08-10 03:44:19','3b72bee8-1967-467b-9c67-1b98edf611ee',NULL),
	(3,39,1,'2019-08-10 03:44:25','2019-08-10 03:44:25','9deb29d0-81b7-4488-ab60-11032a917396','Tech Lead'),
	(4,40,1,'2019-08-10 03:44:27','2019-08-10 03:44:27','137d4b96-8b55-40af-9749-5d46694d6daa','Tech Lead'),
	(5,41,1,'2019-08-10 03:44:27','2019-08-10 03:44:27','9d169b8a-ef78-42b0-bc8e-137618b411dc',NULL),
	(6,42,1,'2019-08-10 03:44:32','2019-08-10 03:44:32','1ff70ede-9795-43b0-af4e-2db57f8084b6','Tech Lead'),
	(7,43,1,'2019-08-10 03:44:32','2019-08-10 03:44:32','fbc68447-d5b4-4fd8-a402-75f28932b809',NULL),
	(8,44,1,'2019-08-10 03:44:38','2019-08-10 03:44:38','e61437cc-7fdb-487a-9ec8-087c9f9707fe','Tech Lead'),
	(9,45,1,'2019-08-10 03:44:38','2019-08-10 03:44:38','18cab7e3-1c28-4318-894c-9b7ada62d710','Tech Lead'),
	(12,49,1,'2019-08-10 03:44:39','2019-08-10 03:44:39','a7467b5d-92be-405b-91da-e34eaef4a63f','Tech Lead'),
	(13,50,1,'2019-08-10 03:44:39','2019-08-10 03:44:39','d5d62747-97bd-4f34-9564-130dcc445092','Tech Lead'),
	(14,52,1,'2019-08-10 03:45:19','2019-08-10 03:45:19','7a7266f9-814e-44a3-9473-934ca3bff00a',NULL),
	(15,53,1,'2019-08-10 03:45:27','2019-08-10 03:45:27','9c14b48e-9029-43b1-a25b-e4852b0fe04c',NULL),
	(16,54,1,'2019-08-10 03:45:33','2019-08-10 03:45:33','86877dae-f3b6-4ee3-ac98-913420a8d10c','Team lead'),
	(17,55,1,'2019-08-10 03:45:35','2019-08-10 03:45:35','f4f73ef0-b768-459c-973b-0e595f7b51c5','Team Lead'),
	(18,56,1,'2019-08-10 03:45:38','2019-08-10 03:45:38','25824bd0-cd18-40a1-bbab-e575aacdfc9d','Team Lead'),
	(19,57,1,'2019-08-10 03:45:38','2019-08-10 03:45:38','840d9da1-d89c-47cb-b21a-f90f452b785a',NULL),
	(20,58,1,'2019-08-10 03:45:44','2019-08-10 03:45:44','08cc3e2e-c843-462b-b0a7-0541cadcfc41','Team Lead'),
	(21,59,1,'2019-08-10 03:45:44','2019-08-10 03:45:44','cc3c8918-2cc2-49b4-9761-2d70fb4d9b51',NULL),
	(22,60,1,'2019-08-10 03:45:49','2019-08-10 03:45:49','47da4648-2fd7-44a5-adc8-0f25fba9783e','Team Lead'),
	(23,61,1,'2019-08-10 03:45:49','2019-08-10 03:45:49','92b338b2-1ae0-4e57-be8d-49b0c3d0c722','De'),
	(24,62,1,'2019-08-10 03:45:50','2019-08-10 03:45:50','8d63dc65-c1ef-4406-9545-54b90589ed6f','Team Lead'),
	(25,63,1,'2019-08-10 03:45:50','2019-08-10 03:45:50','97bf251a-6e4c-4914-a409-0990626b359d','Designer'),
	(28,67,1,'2019-08-10 03:45:52','2019-08-10 03:45:52','442ff49b-c5d4-4c9e-8cca-7053e8e7200a','Team Lead'),
	(29,68,1,'2019-08-10 03:45:52','2019-08-10 03:45:52','d441c44f-5397-41b6-865a-765549a4772f','Designer');
ALTER TABLE `mod_matrixcontent_personroles` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_plugins` WRITE;
ALTER TABLE `mod_plugins` DISABLE KEYS;
REPLACE INTO `mod_plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKeyStatus`, `licensedEdition`, `installDate`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(2,'redactor','2.3.3.2','2.3.0','unknown',NULL,'2019-08-10 00:05:34','2019-08-10 00:05:34','2019-08-10 02:29:37','b2c3b002-b693-4e29-bbb9-7c845e233fe2');
ALTER TABLE `mod_plugins` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_migrations` WRITE;
ALTER TABLE `mod_migrations` DISABLE KEYS;
REPLACE INTO `mod_migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,NULL,'app','Install','2019-08-06 14:20:28','2019-08-06 14:20:28','2019-08-06 14:20:28','f707187d-96d8-48fb-ab08-7e281b4ff6f1'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','97ad744b-e8d7-4ed3-8568-3bd02d56d4d2'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','66a12bee-38a0-4be5-b317-255944ab158c'),
	(4,NULL,'app','m150403_184533_field_version','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','801d0a50-fc07-4124-8a8a-1a9122fbc3ac'),
	(5,NULL,'app','m150403_184729_type_columns','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','5e155d69-972a-4f63-9be5-93f0fda143eb'),
	(6,NULL,'app','m150403_185142_volumes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','aa7e3cea-2981-43f2-891c-dfc4d7b8cbbe'),
	(7,NULL,'app','m150428_231346_userpreferences','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','273034f4-6462-459a-96fe-1b142e10c584'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','832d16c7-19b9-4248-9ec6-8eb5e11c05d0'),
	(9,NULL,'app','m150617_213829_update_email_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','a804992f-7d56-4129-ab17-898e0c1b8105'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','46b48e58-0258-4683-9fef-0d754e7ea264'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','42730d4e-5ce4-4f50-a3f2-2142a8679b8d'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','06846170-32a2-4438-a8d1-8716496394ac'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','dbf0b32c-302d-4240-bf95-c307494a53f2'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','e5eabbfb-6ba8-4b3d-b726-48b2d8bce5ff'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','15f0d7be-e06f-411b-bf97-5c51f1377330'),
	(16,NULL,'app','m151209_000000_move_logo','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','174bdbef-045e-4904-8430-6e7021866c82'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','df14522f-f121-4b1d-96d2-edcef3e7b9af'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','cf7846a0-5b07-4892-b74d-bb0e8d7061ca'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','d6e33176-7c29-4023-8eab-fead2ed89c93'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','941da4b3-34d0-4efb-bc1e-7eb6e8989087'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','09eceee1-27c6-460e-8bb4-c34ba4c4b1d8'),
	(22,NULL,'app','m160727_194637_column_cleanup','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','36f7367a-f1f4-48ee-a6f6-477c6e4a3493'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','47baf4cc-b2fb-47ea-b4b6-b55b7d669460'),
	(24,NULL,'app','m160807_144858_sites','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','fc0170d3-45e3-4194-96dc-d10e9b6b15d2'),
	(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','585ed2c5-db53-42e7-ad33-6ad137b59082'),
	(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','bd11c9eb-95f0-4ceb-b598-200c6064dabc'),
	(27,NULL,'app','m160912_230520_require_entry_type_id','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','2f9ab60c-1c08-4fbd-aca6-4f7ce71b7045'),
	(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','032b2671-255c-4c07-ab6b-96def307d229'),
	(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','0225765f-1102-4ef1-8606-2a3529f96c23'),
	(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','117243f2-3d2d-4cbe-9b4f-3a7622f0383e'),
	(31,NULL,'app','m160925_113941_route_uri_parts','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','7ab978ff-fd70-41de-b054-4dfbd96aa7e1'),
	(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','b1cf7fc6-fd34-4b60-8ab5-345113dc7a71'),
	(33,NULL,'app','m161007_130653_update_email_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','23463909-e701-49fc-b89d-a3ff2dcb1769'),
	(34,NULL,'app','m161013_175052_newParentId','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','069c1ec8-0e4d-42d7-afa2-dfc916e2180c'),
	(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','29e0b571-ca34-4ba3-958d-161382660865'),
	(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','ddf5d8ca-7646-40cb-a215-cd542b795056'),
	(37,NULL,'app','m161025_000000_fix_char_columns','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','38c07898-8836-401c-bb60-44599d9cfe77'),
	(38,NULL,'app','m161029_124145_email_message_languages','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','dd5d0070-86ac-406c-9346-8d128557a739'),
	(39,NULL,'app','m161108_000000_new_version_format','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','ef9ba724-5f49-4653-902e-ebb3a3f9b196'),
	(40,NULL,'app','m161109_000000_index_shuffle','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','a2f2bf64-43c2-4abc-9178-cd1ce88b9ca3'),
	(41,NULL,'app','m161122_185500_no_craft_app','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','c7660701-9eb9-456e-a280-528275811412'),
	(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','52fc77e2-083b-401d-bb57-34d889079c9b'),
	(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','582b1baa-38dd-44c7-913d-0bfa67dc1b4d'),
	(44,NULL,'app','m170114_161144_udates_permission','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','1ffa61b3-681f-4fc5-a109-bad937cc72e2'),
	(45,NULL,'app','m170120_000000_schema_cleanup','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','46666514-ca81-4b0f-bcf1-0a217f06a8b5'),
	(46,NULL,'app','m170126_000000_assets_focal_point','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','63fffeff-1298-4742-b880-719fa6c76626'),
	(47,NULL,'app','m170206_142126_system_name','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','96c4b0ba-9b5e-429d-87c2-ed7703003bfe'),
	(48,NULL,'app','m170217_044740_category_branch_limits','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','697f05c8-4660-4ae8-92a0-620315782a84'),
	(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','6a26edba-7ad8-46e9-964e-997a0d709d72'),
	(50,NULL,'app','m170223_224012_plain_text_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','8afe8455-a795-4f25-a1ec-9f75b6dfaf47'),
	(51,NULL,'app','m170227_120814_focal_point_percentage','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','4b258171-9aa4-47eb-8edb-b3625213b498'),
	(52,NULL,'app','m170228_171113_system_messages','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','3864cc5b-679d-4703-9209-6b748a013bc2'),
	(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','f593ddb3-ab41-48c2-9952-60991c4c5fda'),
	(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','f3ae4097-8d91-4382-9eaf-a7a21a1bcbd9'),
	(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','9b5540f3-bd52-46b9-9abf-e1a4822efbec'),
	(56,NULL,'app','m170612_000000_route_index_shuffle','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','5c51cc9c-05de-4086-bbba-b82d1b77a197'),
	(57,NULL,'app','m170621_195237_format_plugin_handles','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','e04c5b49-9238-487a-9e11-31e6ec996696'),
	(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','08979dee-343a-41b7-b37b-9d95cf1de239'),
	(59,NULL,'app','m170630_161028_deprecation_changes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','1c8f9ca6-e0b7-411f-a5a5-73541347d74f'),
	(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','0d467eaa-941a-4edc-8338-d5509870f3f6'),
	(61,NULL,'app','m170704_134916_sites_tables','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','1af87dfd-47ee-4a19-8533-5cdd61a931f3'),
	(62,NULL,'app','m170706_183216_rename_sequences','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','fe2ccc22-00a2-49d9-9806-96ec3ad1bb09'),
	(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','a6ed9b53-b6a6-4d1f-a4c4-c5c2e255c2e8'),
	(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','67edc18c-b451-483c-8db5-58a36aca08d0'),
	(65,NULL,'app','m170810_201318_create_queue_table','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','4f8ba23c-f07f-42f1-a2d8-7601880e8330'),
	(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','8996a894-c484-4492-a4cf-e7d6ec71caca'),
	(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','af92ee60-e26d-4657-a8da-2b75df8c1fe1'),
	(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','9341b724-7a24-468f-8472-7bc0d0114ccb'),
	(69,NULL,'app','m171011_214115_site_groups','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','27ef6688-83b8-4fc0-b25c-3de48087b128'),
	(70,NULL,'app','m171012_151440_primary_site','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','3405a79f-6d9a-49d8-bb75-cef217fee810'),
	(71,NULL,'app','m171013_142500_transform_interlace','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','af72c10b-a8ba-48f5-918a-3920e0de0449'),
	(72,NULL,'app','m171016_092553_drop_position_select','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','f01c251f-794b-48eb-91e1-4b4aac90be8a'),
	(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','edb9b1dc-ce53-467c-9e8e-0790ff9692a4'),
	(74,NULL,'app','m171107_000000_assign_group_permissions','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','7949e4e8-90d9-4360-82f7-14e1a2b33648'),
	(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','6b0abe77-10f3-40b0-b216-d5aebe24177b'),
	(76,NULL,'app','m171126_105927_disabled_plugins','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','220843ca-9092-4799-b3a0-db8fa1ded3c1'),
	(77,NULL,'app','m171130_214407_craftidtokens_table','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','715a37c6-617c-42b6-9ba0-04986dbdb6a1'),
	(78,NULL,'app','m171202_004225_update_email_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','3da017cb-27a0-4d88-9973-f32eeab6f40d'),
	(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','930ceff1-d094-41cc-917b-11b573408cff'),
	(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','c30c5161-dc64-4c07-850e-20714588666b'),
	(81,NULL,'app','m171218_143135_longtext_query_column','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','96fac092-e04c-4592-98dd-0bb74c5222b5'),
	(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','49994fdc-2993-4c64-90e8-e4636b670800'),
	(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','20807446-0f12-4e47-acf0-f73c70777ac2'),
	(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','00de1eb3-7b3a-46b1-a955-39808a618e9a'),
	(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','0586fc30-f033-4a2b-860b-8c3aa878b37e'),
	(86,NULL,'app','m180128_235202_set_tag_slugs','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','2058fa61-900f-4ada-bd70-147197c422f1'),
	(87,NULL,'app','m180202_185551_fix_focal_points','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','2ec6691a-d20c-4722-8939-0f1f2ee49c74'),
	(88,NULL,'app','m180217_172123_tiny_ints','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','11e9999a-0c09-4590-81cd-e48c3fe6d93d'),
	(89,NULL,'app','m180321_233505_small_ints','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','31a0966f-6ffe-469a-8dd0-299a08a94ca6'),
	(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','27b93390-3615-41b6-8ad5-2e75a9a7e2e0'),
	(91,NULL,'app','m180404_182320_edition_changes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','0bc9e474-cd42-433a-b213-f647bdfde616'),
	(92,NULL,'app','m180411_102218_fix_db_routes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','33ea3e6a-53e3-466d-99a8-f3f602215833'),
	(93,NULL,'app','m180416_205628_resourcepaths_table','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','e5916366-a3b3-43ed-8318-d19717a690a6'),
	(94,NULL,'app','m180418_205713_widget_cleanup','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','a41fcec7-962c-4f43-b1d4-8cdefc811195'),
	(95,NULL,'app','m180425_203349_searchable_fields','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','91ee8a55-f5ab-49ee-b9f2-adef731b18e0'),
	(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','4c84ce1b-dd06-427e-8b44-fb79b24738ec'),
	(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','7b53e8f6-1ce5-46cb-a9d7-d7daaa225b8f'),
	(98,NULL,'app','m180518_173000_permissions_to_uid','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','4f3661e7-f796-4ce5-870e-27876016b41e'),
	(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','7aad48cc-e485-47a9-bddb-d9a19bcc3434'),
	(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','5bca081e-c51a-4335-9595-5344563b9183'),
	(101,NULL,'app','m180731_162030_soft_delete_sites','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','7d1e6895-33fb-4ee0-ab1c-3de3ccb73982'),
	(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','c2ed03e8-8c40-451d-afe8-2d96b25bd474'),
	(103,NULL,'app','m180810_214439_soft_delete_elements','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','4bc8a448-b549-4a82-bb1a-e6ac9c665a15'),
	(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','868d95f9-b155-43bc-bb2e-8029a1ecd7dd'),
	(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','d76b8949-adf8-464c-818e-f344363de946'),
	(106,NULL,'app','m180904_112109_permission_changes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','f057431e-0995-459b-9868-60f68e7be268'),
	(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','1e40545a-6c82-4ed8-8a63-975776078d50'),
	(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','30289554-c851-4b79-a30c-947f1f4a79cb'),
	(109,NULL,'app','m181016_183648_set_default_user_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','f1106b36-be4d-445f-a0eb-e74729c251f2'),
	(110,NULL,'app','m181017_225222_system_config_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','69e1da26-dce1-43d3-a695-53e5ff47263b'),
	(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','820ae0de-2c25-42b5-9a1d-336aeecc4dfb'),
	(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','4a31ef4e-8db9-49de-b578-a91d9f64e1b6'),
	(113,NULL,'app','m181112_203955_sequences_table','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','1022d783-597b-402a-87f0-914f1c2f0453'),
	(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','07483667-b02d-4989-8f52-80758aa03960'),
	(115,NULL,'app','m181128_193942_fix_project_config','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','63ec0668-06ed-42ed-9d47-a52c91b2c1ba'),
	(116,NULL,'app','m181130_143040_fix_schema_version','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','e0e24e32-1449-41dc-8dd6-3c651bde3712'),
	(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','191bed48-7e16-4a1e-bc83-55cdd9eb5477'),
	(118,NULL,'app','m181213_102500_config_map_aliases','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','181d65df-7d82-431e-b10f-472f3c03410f'),
	(119,NULL,'app','m181217_153000_fix_structure_uids','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','61f5347f-8bea-4557-bdbb-b350f4413328'),
	(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','666f0d9c-3fd8-40f2-93a4-acff17a59cc7'),
	(121,NULL,'app','m190108_110000_cleanup_project_config','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','bc91f602-bf4c-44f5-90d1-b3a41ad7391f'),
	(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','f42f24a2-d255-4a61-84c4-37801267db14'),
	(123,NULL,'app','m190109_172845_fix_colspan','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','e65fd61d-e849-4f42-b5bf-cc3e025d30bb'),
	(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','2ed4d89a-88e6-4aa8-bcfd-8c7866138833'),
	(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','8672734d-96f7-476e-8e10-1982bba300bd'),
	(126,NULL,'app','m190112_124737_fix_user_settings','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','4fecbeb3-f681-401e-b4d1-350d59285b02'),
	(127,NULL,'app','m190112_131225_fix_field_layouts','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','cf69846d-0ed4-4011-8d4d-5a6b11fcb642'),
	(128,NULL,'app','m190112_201010_more_soft_deletes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','0da611e0-cdd2-42c1-a74f-f84a08cb17d4'),
	(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','d041da2b-f993-4889-90f1-d160ea7ffbf6'),
	(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','e492ef93-055b-420c-a24f-05edf1fe0acf'),
	(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','7d239f3e-ac5d-4197-8d56-da3fe5d70663'),
	(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','6fd55adb-17c5-46d3-9856-b55fc1982f43'),
	(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','6be6ada8-4205-4ac4-8c2c-7a5a2398716a'),
	(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','75afc508-9109-4f5c-be03-515540c24b25'),
	(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','ab0b7e1a-3a90-40ab-84b2-cf54ecc3d47e'),
	(136,NULL,'app','m190312_152740_element_revisions','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','35062330-e479-4231-a62a-f1c2888d21ae'),
	(137,NULL,'app','m190327_235137_propagation_method','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','00cd6da1-a018-45a8-94d9-26f14794efc8'),
	(138,NULL,'app','m190401_223843_drop_old_indexes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','3fd369a8-5257-49cb-b6d3-7d2579205c28'),
	(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','8c617275-e8c8-40a7-9531-389a7f719a83'),
	(140,NULL,'app','m190417_085010_add_image_editor_permissions','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','f4a9a7b5-781d-4225-bbb9-af26c9453565'),
	(141,NULL,'app','m190502_122019_store_default_user_group_uid','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','b9809f35-a409-417e-9150-555773d33de9'),
	(142,NULL,'app','m190504_150349_preview_targets','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','4f08833c-9815-400f-b7db-c62827833be3'),
	(143,NULL,'app','m190516_184711_job_progress_label','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','b2913665-9274-4e2c-918e-6e2d93b1fdb2'),
	(144,NULL,'app','m190523_190303_optional_revision_creators','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','8de6cf34-8275-4048-a17f-1acabe4f9f7a'),
	(145,NULL,'app','m190529_204501_fix_duplicate_uids','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','aa68a462-de57-452a-ac46-5291abfbcca0'),
	(146,NULL,'app','m190605_223807_unsaved_drafts','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','129804e1-c81c-4f3e-a47c-c2419dd8e63c'),
	(147,NULL,'app','m190607_230042_entry_revision_error_tables','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','c43a72d6-ba6b-4247-90b5-422ab828cf7b'),
	(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','896e5533-f881-4d92-81b4-624f5f8663a7'),
	(149,NULL,'app','m190624_234204_matrix_propagation_method','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','2694c351-20a2-4e36-a8b1-6003eefbe414'),
	(150,NULL,'app','m190711_153020_drop_snapshots','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','582f3541-abdd-47ad-9de0-047f2bcac73e'),
	(151,NULL,'app','m190712_195914_no_draft_revisions','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','5f29f1e5-fe1f-4c1a-bfcd-04751e46d646'),
	(152,NULL,'app','m190723_140314_fix_preview_targets_column','2019-08-06 14:20:29','2019-08-06 14:20:29','2019-08-06 14:20:29','33f8bd49-24ca-429f-96f4-e4495af2c39c'),
	(153,2,'plugin','m180430_204710_remove_old_plugins','2019-08-10 00:05:35','2019-08-10 00:05:35','2019-08-10 00:05:35','3c2caf6c-c0bc-462c-a459-4b6fcb36c85f'),
	(154,2,'plugin','Install','2019-08-10 00:05:36','2019-08-10 00:05:36','2019-08-10 00:05:36','ae3f7647-e785-4dc2-b6d0-72fc6f4c4794'),
	(155,2,'plugin','m190225_003922_split_cleanup_html_settings','2019-08-10 00:05:36','2019-08-10 00:05:36','2019-08-10 00:05:36','f6ff6c67-3585-49d4-9717-6a1d05866d83');
ALTER TABLE `mod_migrations` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_queue` WRITE;
ALTER TABLE `mod_queue` DISABLE KEYS;
ALTER TABLE `mod_queue` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_relations` WRITE;
ALTER TABLE `mod_relations` DISABLE KEYS;
REPLACE INTO `mod_relations` (`id`, `fieldId`, `sourceId`, `sourceSiteId`, `targetId`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(4,22,38,NULL,4,1,'2019-08-10 03:44:19','2019-08-10 03:44:19','36c0c0bc-f201-4dbe-8ead-b8002f4c7496'),
	(6,22,39,NULL,4,1,'2019-08-10 03:44:25','2019-08-10 03:44:25','4f295b09-c49f-4295-b75e-e2e94a47c0be'),
	(8,22,40,NULL,4,1,'2019-08-10 03:44:27','2019-08-10 03:44:27','54498b3a-6be0-4d32-a010-924f871742e2'),
	(10,22,42,NULL,4,1,'2019-08-10 03:44:32','2019-08-10 03:44:32','09bba9cb-2286-414d-9b55-de1675c32774'),
	(11,22,43,NULL,5,1,'2019-08-10 03:44:32','2019-08-10 03:44:32','be17cb14-4a87-4be7-9f18-07d5c236a9d0'),
	(13,22,44,NULL,4,1,'2019-08-10 03:44:38','2019-08-10 03:44:38','bdf4d626-f3ca-47ed-a6c8-84dd34173fd7'),
	(14,22,45,NULL,5,1,'2019-08-10 03:44:38','2019-08-10 03:44:38','589f7fe1-2fcd-48b2-abd4-2362a16a6f85'),
	(18,24,48,NULL,28,1,'2019-08-10 03:44:39','2019-08-10 03:44:39','40f4f8d6-1d80-41cc-9617-911602ed920e'),
	(19,22,49,NULL,4,1,'2019-08-10 03:44:39','2019-08-10 03:44:39','3826ab8a-7a88-49c8-b8c6-5bc8dd73e9f6'),
	(20,22,50,NULL,5,1,'2019-08-10 03:44:39','2019-08-10 03:44:39','f850230f-9fc2-47ea-8653-4239fc4a20a7'),
	(24,22,53,NULL,2,1,'2019-08-10 03:45:27','2019-08-10 03:45:27','dbdac8e9-756a-4d32-8628-80f0f20cfaad'),
	(26,22,54,NULL,2,1,'2019-08-10 03:45:33','2019-08-10 03:45:33','78d10188-6c1b-4e54-a0e5-64221f922585'),
	(28,22,55,NULL,2,1,'2019-08-10 03:45:35','2019-08-10 03:45:35','a82aadae-0000-4fde-831c-db6b44767f07'),
	(30,22,56,NULL,2,1,'2019-08-10 03:45:38','2019-08-10 03:45:38','ff71fc20-d428-4a70-9963-e950c66bc051'),
	(32,22,58,NULL,2,1,'2019-08-10 03:45:44','2019-08-10 03:45:44','a02ba5f4-8e07-40b4-8c2e-1e3f2e8c6c21'),
	(33,22,59,NULL,3,1,'2019-08-10 03:45:44','2019-08-10 03:45:44','8963aed2-229d-4654-8ecf-f03a86d57c54'),
	(35,22,60,NULL,2,1,'2019-08-10 03:45:49','2019-08-10 03:45:49','57cd7d43-719f-4dd6-9bc0-92bd1eb64e05'),
	(36,22,61,NULL,3,1,'2019-08-10 03:45:49','2019-08-10 03:45:49','b4d1541f-72aa-4d66-9d96-07cb58608454'),
	(38,22,62,NULL,2,1,'2019-08-10 03:45:50','2019-08-10 03:45:50','8f13f553-5dcb-4c95-8931-cffcf7d90b3e'),
	(39,22,63,NULL,3,1,'2019-08-10 03:45:50','2019-08-10 03:45:50','345cae8a-cf33-4b49-a885-a413dcb60bdb'),
	(43,24,66,NULL,24,1,'2019-08-10 03:45:52','2019-08-10 03:45:52','1da9665c-8f69-4d32-95f6-c1aaeb455328'),
	(44,22,67,NULL,2,1,'2019-08-10 03:45:52','2019-08-10 03:45:52','89afdc05-fedb-4244-b185-bf38458ccab3'),
	(45,22,68,NULL,3,1,'2019-08-10 03:45:52','2019-08-10 03:45:52','f5128bb9-eb5d-4ee8-afea-5afaeeb7f29b');
ALTER TABLE `mod_relations` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_resourcepaths` WRITE;
ALTER TABLE `mod_resourcepaths` DISABLE KEYS;
REPLACE INTO `mod_resourcepaths` (`hash`, `path`) VALUES 
	('11d61747','@craft/web/assets/login/dist'),
	('17314154','@lib/velocity'),
	('19d0a08a','@craft/web/assets/craftsupport/dist'),
	('1a10e922','@craft/web/assets/updates/dist'),
	('23c1b674','@craft/web/assets/dashboard/dist'),
	('25dfd780','@lib/jquery-ui'),
	('26c59dce','@craft/web/assets/feed/dist'),
	('292e1ddc','@lib/element-resize-detector'),
	('304b32d6','@craft/web/assets/routes/dist'),
	('3677474','@craft/web/assets/editentry/dist'),
	('38c6b507','@craft/web/assets/edituser/dist'),
	('3c0b5518','@craft/web/assets/matrixsettings/dist'),
	('3e9477d1','@lib'),
	('47266b40','@craft/web/assets/plugins/dist'),
	('556910ad','@lib/element-resize-detector'),
	('5998daf1','@lib/jquery-ui'),
	('5a241a41','@craft/web/assets/assetindexes/dist'),
	('5a8290bf','@craft/web/assets/feed/dist'),
	('5a9b50c7','@craft/web/assets/clearcaches/dist'),
	('5d1f838a','@craft/web/assets/systemmessages/dist'),
	('5f86bb05','@craft/web/assets/dashboard/dist'),
	('6597adfb','@craft/web/assets/craftsupport/dist'),
	('6657e453','@craft/web/assets/updates/dist'),
	('6b764c25','@lib/velocity'),
	('6beb629','@bower/jquery/dist'),
	('6d911a36','@craft/web/assets/login/dist'),
	('7751e3cd','@lib/jquery.payment'),
	('7af9bb58','@bower/jquery/dist'),
	('80c614ed','@craft/web/assets/recententries/dist'),
	('80d86ce3','@craft/web/assets/userpermissions/dist'),
	('82b7baa9','@craft/web/assets/utilities/dist'),
	('84b1aaff','@lib/d3'),
	('8a0254da','@craft/redactor/assets/field/dist'),
	('8a148aae','@lib/picturefill'),
	('8a6c6ed0','@craft/web/assets/matrix/dist'),
	('8a9d12df','@craft/web/assets/tablesettings/dist'),
	('8db0b66c','@lib/jquery-touch-events'),
	('8f36bce5','@lib/prismjs'),
	('92fc8b50','@lib/fileupload'),
	('9b409e20','@verbb/fieldmanager/resources/dist'),
	('a22daa5b','@lib/selectize'),
	('a24a6947','@lib/fabric'),
	('a28fa0aa','@craft/web/assets/fields/dist'),
	('a4028f12','@craft/web/assets/cp/dist'),
	('a841eed1','@lib/xregexp'),
	('b16eebc','@lib/jquery.payment'),
	('b70cbd79','@lib/garnishjs'),
	('be7c5683','@craft/web/assets/updateswidget/dist'),
	('c23b5bf2','@craft/web/assets/updateswidget/dist'),
	('cb140fa9','@craft/web/assets/generalsettings/dist'),
	('cb4bb008','@lib/garnishjs'),
	('d13eb21e','@craft/web/assets/pluginstore/dist'),
	('d406e3a0','@lib/xregexp'),
	('d8458263','@craft/web/assets/cp/dist'),
	('de0d6436','@lib/fabric'),
	('de6aa72a','@lib/selectize'),
	('ebf9bbd5','@lib/timepicker'),
	('eebb8621','@lib/fileupload'),
	('f1f7bb1d','@lib/jquery-touch-events'),
	('f3d009f','@craft/web/assets/editcategory/dist'),
	('f5425fc3','@craft/web/assets/updater/dist'),
	('f65387df','@lib/picturefill'),
	('f758c95a','@vendor/craftcms/redactor/lib/redactor'),
	('f8f6a78e','@lib/d3'),
	('fc81199c','@craft/web/assets/recententries/dist'),
	('fef0b7d8','@craft/web/assets/utilities/dist');
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
	(1,'firstname',0,1,' mod '),
	(1,'lastname',0,1,' creative '),
	(1,'fullname',0,1,' mod creative '),
	(1,'email',0,1,' selvin modcreativeinc com '),
	(1,'slug',0,1,''),
	(2,'slug',0,1,' marketing '),
	(2,'title',0,1,' marketing '),
	(3,'slug',0,1,' design '),
	(3,'title',0,1,' design '),
	(4,'slug',0,1,' development '),
	(4,'title',0,1,' development '),
	(5,'slug',0,1,' information technology '),
	(5,'title',0,1,' information technology '),
	(8,'field',40,1,''),
	(10,'slug',0,1,' building search innovation '),
	(10,'field',30,1,' search innovation '),
	(10,'field',31,1,''),
	(12,'slug',0,1,' building google glass '),
	(12,'field',30,1,' google glass '),
	(12,'field',31,1,''),
	(14,'slug',0,1,' floor 1 '),
	(14,'title',0,1,' floor 1 '),
	(14,'field',33,1,' ggf1 '),
	(14,'field',34,1,''),
	(14,'field',32,1,' 1 '),
	(15,'slug',0,1,' floor 2 '),
	(15,'field',33,1,' ggf2 '),
	(15,'field',34,1,''),
	(15,'field',32,1,' 2 '),
	(17,'slug',0,1,' floor 1 '),
	(17,'title',0,1,' floor 1 '),
	(17,'field',33,1,' sif1 '),
	(17,'field',34,1,''),
	(17,'field',32,1,' 1 '),
	(18,'slug',0,1,' floor 2 '),
	(18,'title',0,1,' floor 2 '),
	(18,'field',33,1,' sif2 '),
	(18,'field',34,1,''),
	(18,'field',32,1,' 2 '),
	(15,'title',0,1,' floor 2 '),
	(10,'title',0,1,' building search innovation '),
	(12,'title',0,1,' building google glass '),
	(20,'slug',0,1,' room g201 '),
	(20,'title',0,1,' room g201 '),
	(20,'field',36,1,' g201 '),
	(20,'field',38,1,''),
	(20,'field',37,1,' b60f2rg201 '),
	(22,'slug',0,1,' room g209 '),
	(22,'title',0,1,' room g209 '),
	(22,'field',36,1,' g209 '),
	(22,'field',38,1,''),
	(22,'field',37,1,' b60f2rg209 '),
	(23,'slug',0,1,' room g103 '),
	(23,'title',0,1,' room g103 '),
	(23,'field',36,1,' g103 '),
	(23,'field',38,1,''),
	(23,'field',37,1,' b60f1rg103 '),
	(24,'slug',0,1,' room g106 '),
	(24,'title',0,1,' room g106 '),
	(24,'field',36,1,' g106 '),
	(24,'field',38,1,''),
	(24,'field',37,1,' b60f1rg106 '),
	(8,'title',0,1,' campus google campus '),
	(8,'field',39,1,' google campus '),
	(8,'slug',0,1,' campus google campus '),
	(25,'slug',0,1,' campus apple campus '),
	(25,'title',0,1,' campus apple campus '),
	(25,'field',39,1,' apple campus '),
	(25,'field',40,1,''),
	(26,'slug',0,1,' building design and engineering '),
	(26,'field',31,1,''),
	(27,'slug',0,1,' floor 1 '),
	(27,'title',0,1,' floor 1 '),
	(27,'field',32,1,' 1 '),
	(27,'field',34,1,''),
	(27,'field',33,1,' def1 '),
	(28,'slug',0,1,' b60f1rc103 1 1 '),
	(28,'title',0,1,' room c103 '),
	(28,'field',36,1,' c103 '),
	(28,'field',38,1,''),
	(28,'field',37,1,' b60f1rc103 '),
	(29,'slug',0,1,' b60f1rc106 1 1 '),
	(29,'title',0,1,' room c106 '),
	(29,'field',36,1,' c106 '),
	(29,'field',38,1,''),
	(29,'field',37,1,' b60f1rc106 '),
	(30,'slug',0,1,' b60f2 1 '),
	(30,'title',0,1,' floor 2 '),
	(30,'field',32,1,' 2 '),
	(30,'field',34,1,''),
	(30,'field',33,1,' b60f2 '),
	(31,'slug',0,1,' room x201 1 '),
	(31,'title',0,1,' room x201 '),
	(31,'field',36,1,' x201 '),
	(31,'field',38,1,''),
	(31,'field',37,1,' b60f2rx201 '),
	(32,'slug',0,1,' room x209 1 '),
	(32,'title',0,1,' room x209 '),
	(32,'field',36,1,' x209 '),
	(32,'field',38,1,''),
	(32,'field',37,1,' b60f2rx209 '),
	(33,'slug',0,1,' building keyboard lab '),
	(33,'title',0,1,' building keyboard lab '),
	(33,'field',30,1,' keyboard lab '),
	(33,'field',31,1,''),
	(34,'slug',0,1,' b12155f1 1 '),
	(34,'title',0,1,' floor 1 '),
	(34,'field',32,1,' 1 '),
	(34,'field',34,1,''),
	(34,'field',33,1,' b12155f1 '),
	(35,'slug',0,1,' b12155f2 1 '),
	(35,'title',0,1,' floor 2 '),
	(35,'field',32,1,' 2 '),
	(35,'field',34,1,''),
	(35,'field',33,1,' b12155f2 '),
	(26,'title',0,1,' building design and engineering '),
	(26,'field',30,1,' design and engineering '),
	(48,'slug',0,1,' selvin ortiz '),
	(48,'title',0,1,' selvin ortiz '),
	(48,'field',26,1,' selvin '),
	(48,'field',27,1,' ortiz '),
	(48,'field',25,1,' selvin modcreativeinc com '),
	(48,'field',28,1,''),
	(48,'field',29,1,''),
	(48,'field',24,1,' room c103 '),
	(49,'slug',0,1,''),
	(50,'slug',0,1,''),
	(66,'slug',0,1,' phil nelson '),
	(66,'title',0,1,' phil nelson '),
	(66,'field',26,1,' phil '),
	(66,'field',27,1,' nelson '),
	(66,'field',25,1,' phil modcreativeinc com '),
	(66,'field',28,1,''),
	(66,'field',29,1,''),
	(66,'field',24,1,' room g106 '),
	(67,'slug',0,1,''),
	(68,'slug',0,1,'');
ALTER TABLE `mod_searchindex` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sections` WRITE;
ALTER TABLE `mod_sections` DISABLE KEYS;
REPLACE INTO `mod_sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagationMethod`, `previewTargets`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,2,'People','people','structure',0,'all',NULL,'2019-08-09 23:56:26','2019-08-10 02:57:34',NULL,'55acf63b-b2c2-454b-9842-fdecf05be856'),
	(2,3,'Places','places','structure',0,'all',NULL,'2019-08-09 23:57:21','2019-08-10 03:27:29',NULL,'84c2ec09-b2d9-4812-addd-abc792357963');
ALTER TABLE `mod_sections` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sections_sites` WRITE;
ALTER TABLE `mod_sections_sites` DISABLE KEYS;
REPLACE INTO `mod_sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,1,'people/{slug}','people/_person',1,'2019-08-09 23:56:26','2019-08-10 02:57:34','749d1a60-2ece-45cd-84d2-a4e955c8ac44'),
	(2,2,1,1,'{parent.uri ?? \'places\'}/{slug}','places/_place',1,'2019-08-09 23:57:22','2019-08-10 03:27:29','72169887-f4ad-46ee-80ff-c05595fe99ae');
ALTER TABLE `mod_sections_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sequences` WRITE;
ALTER TABLE `mod_sequences` DISABLE KEYS;
ALTER TABLE `mod_sequences` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sessions` WRITE;
ALTER TABLE `mod_sessions` DISABLE KEYS;
REPLACE INTO `mod_sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,'1J5rpIMco3sWMhhCmpjq14Wb45Uq3KTS2zPXpZHcooRO2msdIA5CJlC-1_Ef3IgM7ZfI9FNlEMLtGTAtyFvIUnmNVwmn1956XNgx','2019-08-09 23:26:18','2019-08-10 00:20:36','169c1e21-cc3f-4fe4-80b1-e3deb882a6d6'),
	(2,1,'5ErgChY2KNrZCtxhfmxstPwAOPAb96j_xtgckDUYXIfOqXeFn2iLtSlr6HA6QSl5abtl3NQWZR7yhW4rshr3B1N-2CtbXBxULlzX','2019-08-10 02:29:32','2019-08-10 03:51:51','3e070624-9144-4ba6-9015-f057ac2b7514');
ALTER TABLE `mod_sessions` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_shunnedmessages` WRITE;
ALTER TABLE `mod_shunnedmessages` DISABLE KEYS;
ALTER TABLE `mod_shunnedmessages` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sitegroups` WRITE;
ALTER TABLE `mod_sitegroups` DISABLE KEYS;
REPLACE INTO `mod_sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,'ModCore','2019-08-06 14:20:24','2019-08-06 14:20:24',NULL,'ff79c85e-c1a7-4b70-b7f9-8d73726d5506');
ALTER TABLE `mod_sitegroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sites` WRITE;
ALTER TABLE `mod_sites` DISABLE KEYS;
REPLACE INTO `mod_sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,1,1,'ModCore','default','en-US',1,'$DEFAULT_SITE_URL',1,'2019-08-06 14:20:24','2019-08-06 14:20:24',NULL,'c1732a15-3da9-4623-9804-bb1538425f67');
ALTER TABLE `mod_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_structures` WRITE;
ALTER TABLE `mod_structures` DISABLE KEYS;
REPLACE INTO `mod_structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,1,'2019-08-09 23:54:14','2019-08-09 23:54:14',NULL,'d6205b4f-1b8a-4afe-a3f5-728fac8df0e7'),
	(2,1,'2019-08-09 23:56:26','2019-08-09 23:56:26',NULL,'99a5afbe-485a-4886-8da1-2070ffec24b6'),
	(3,5,'2019-08-09 23:57:21','2019-08-09 23:57:21',NULL,'eee91aaf-9337-42be-81fa-195c750c1a64');
ALTER TABLE `mod_structures` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_structureelements` WRITE;
ALTER TABLE `mod_structureelements` DISABLE KEYS;
REPLACE INTO `mod_structureelements` (`id`, `structureId`, `elementId`, `root`, `lft`, `rgt`, `level`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,NULL,1,1,10,0,'2019-08-10 00:01:41','2019-08-10 00:02:32','b96b85cb-bc69-41aa-8941-43cb6191193c'),
	(2,1,2,1,4,5,1,'2019-08-10 00:01:41','2019-08-10 00:02:32','50994d9a-f285-4383-a50e-57fffe737f65'),
	(3,1,3,1,2,3,1,'2019-08-10 00:02:06','2019-08-10 00:02:32','77481f1f-70e3-4336-8f84-6850c70de0a4'),
	(4,1,4,1,6,7,1,'2019-08-10 00:02:13','2019-08-10 00:02:32','439e8e1f-c5d7-4d89-8431-e7f3b950f3cd'),
	(5,1,5,1,8,9,1,'2019-08-10 00:02:27','2019-08-10 00:02:32','812b69d0-6023-45e9-a257-005507a01fa1'),
	(6,2,NULL,6,1,8,0,'2019-08-10 02:59:33','2019-08-10 03:45:52','e3a3e5be-60e1-4808-89ab-9552a2d6f9e5'),
	(7,2,6,6,2,3,1,'2019-08-10 02:59:33','2019-08-10 02:59:33','8aee2a4b-2806-466b-a016-22657c7cd57f'),
	(8,3,NULL,8,1,48,0,'2019-08-10 03:17:50','2019-08-10 03:31:35','6f77c5b0-a204-421d-9c60-814ad59db4f7'),
	(10,3,8,8,2,25,1,'2019-08-10 03:18:18','2019-08-10 03:28:24','e95c8dac-9a74-4c9b-84bf-fb797a53c005'),
	(12,3,10,8,19,24,2,'2019-08-10 03:18:53','2019-08-10 03:28:24','cc27d184-3e49-4701-a0f8-cab976c9ce5c'),
	(14,3,12,8,3,18,2,'2019-08-10 03:19:16','2019-08-10 03:28:24','c733f619-e502-49d5-bed5-b40e6aabdfc7'),
	(16,3,14,8,4,9,3,'2019-08-10 03:20:20','2019-08-10 03:28:24','a8a91bd5-b4cc-40d7-8b39-d44e8f434c99'),
	(17,3,15,8,10,17,3,'2019-08-10 03:20:34','2019-08-10 03:28:24','5ed5189d-6bfc-4e32-8893-d1fcc9fe919e'),
	(19,3,17,8,20,21,3,'2019-08-10 03:22:03','2019-08-10 03:28:24','c120dcf5-2609-4e06-8c37-ef9cf4e2a96e'),
	(20,3,18,8,22,23,3,'2019-08-10 03:22:37','2019-08-10 03:28:24','e06653f4-06d4-4be1-baed-ba53bb60b87c'),
	(22,3,20,8,11,14,4,'2019-08-10 03:26:30','2019-08-10 03:28:24','46d8856e-d14d-47d6-b9b7-f8ef4e379a2e'),
	(23,3,21,8,12,13,5,'2019-08-10 03:26:41','2019-08-10 03:28:24','fc45d4a0-4367-4b84-b314-58744b3c7461'),
	(24,3,22,8,15,16,4,'2019-08-10 03:26:49','2019-08-10 03:28:24','ea0be0bb-1256-4449-aac5-7b11ce6e85c5'),
	(25,3,23,8,5,6,4,'2019-08-10 03:28:10','2019-08-10 03:28:24','76d49abc-8d6e-4ba2-81dc-b737ac23c77e'),
	(26,3,24,8,7,8,4,'2019-08-10 03:28:10','2019-08-10 03:28:24','ca0e1075-2ed2-4e97-a27e-2332bc548f55'),
	(27,3,25,8,26,47,1,'2019-08-10 03:31:35','2019-08-10 03:31:35','ae05f6cf-910d-4e7b-bd1e-30fd23c484df'),
	(28,3,26,8,27,40,2,'2019-08-10 03:31:35','2019-08-10 03:31:35','7b39af0d-53be-41a3-be19-d7a42e6f28f5'),
	(29,3,27,8,28,33,3,'2019-08-10 03:31:35','2019-08-10 03:31:35','28a3fe55-213a-4a22-b49e-891668718778'),
	(30,3,28,8,29,30,4,'2019-08-10 03:31:35','2019-08-10 03:31:35','1ca6a73a-6701-498f-96f4-182882948e41'),
	(31,3,29,8,31,32,4,'2019-08-10 03:31:35','2019-08-10 03:31:35','41c14c08-d95d-43c0-b201-bdb0d044b5d9'),
	(32,3,30,8,34,39,3,'2019-08-10 03:31:35','2019-08-10 03:31:35','655590e1-7bde-417a-9932-3cc1f83ebacb'),
	(33,3,31,8,35,36,4,'2019-08-10 03:31:35','2019-08-10 03:31:35','b3ce3ccb-57f6-4a8e-bc8d-02f9e71e1812'),
	(34,3,32,8,37,38,4,'2019-08-10 03:31:35','2019-08-10 03:31:35','fbab17eb-74e1-48af-b75b-86f09f26aa08'),
	(35,3,33,8,41,46,2,'2019-08-10 03:31:35','2019-08-10 03:31:35','1d14e736-b8c4-4396-9801-1b3e18f925a3'),
	(36,3,34,8,42,43,3,'2019-08-10 03:31:35','2019-08-10 03:31:35','5d26975d-066c-4ece-b343-9711c0084548'),
	(37,3,35,8,44,45,3,'2019-08-10 03:31:35','2019-08-10 03:31:35','2ddd5b26-2719-4cb9-b57b-00d23b57fe04'),
	(39,2,48,6,4,5,1,'2019-08-10 03:44:39','2019-08-10 03:44:39','a1d4c224-8515-4344-8124-1f0c084a13a5'),
	(41,2,66,6,6,7,1,'2019-08-10 03:45:52','2019-08-10 03:45:52','dcf13a9d-0b03-40f1-adb2-386b681a484e');
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
	(1,'admin',NULL,'Mod','Creative','selvin@modcreativeinc.com','$2y$13$ep9C33aUww5.sOWqTZK47.WLmCWCycFK33Mkh5ZveDxuZLOT12ska',1,0,0,0,'2019-08-10 02:29:33',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-08-06 14:20:27','2019-08-06 14:20:27','2019-08-10 02:29:33','d8e7e3d5-0f52-42b1-8164-8171907c6572');
ALTER TABLE `mod_users` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_userpermissions_users` WRITE;
ALTER TABLE `mod_userpermissions_users` DISABLE KEYS;
ALTER TABLE `mod_userpermissions_users` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_userpreferences` WRITE;
ALTER TABLE `mod_userpreferences` DISABLE KEYS;
REPLACE INTO `mod_userpreferences` (`userId`, `preferences`) VALUES 
	(1,'{"language":"en-US","weekStartDay":"1","enableDebugToolbarForSite":false,"enableDebugToolbarForCp":false}');
ALTER TABLE `mod_userpreferences` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_volumes` WRITE;
ALTER TABLE `mod_volumes` DISABLE KEYS;
REPLACE INTO `mod_volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,NULL,'Uploads','uploads','craft\\volumes\\Local',1,'@web/uploads','{"path":"@webroot/uploads"}',1,'2019-08-10 00:08:22','2019-08-10 00:08:22',NULL,'8d7880f3-e3e2-409a-866e-6aa2b3a0f616'),
	(2,NULL,'System','system','craft\\volumes\\Local',1,'@web/system','{"path":"@webroot/system"}',2,'2019-08-10 00:09:16','2019-08-10 00:09:16',NULL,'9b3e91a4-dbdb-4640-9d8e-028f11cfc6ed');
ALTER TABLE `mod_volumes` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_volumefolders` WRITE;
ALTER TABLE `mod_volumefolders` DISABLE KEYS;
REPLACE INTO `mod_volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,NULL,1,'Uploads','','2019-08-10 00:08:22','2019-08-10 00:08:22','0885b97f-4cd1-40a0-ab30-fe9507563265'),
	(2,NULL,2,'System','','2019-08-10 00:09:16','2019-08-10 00:09:16','adf89195-604d-4901-a4d9-a18a36ae40a9'),
	(3,NULL,NULL,'Temporary source',NULL,'2019-08-10 00:09:51','2019-08-10 00:09:51','ff730f11-dfcf-4b6f-9176-5a0ccee7ec12'),
	(4,3,NULL,'user_1','user_1/','2019-08-10 00:09:51','2019-08-10 00:09:51','6dc2887c-4f8a-4568-8189-7c75924f5d97');
ALTER TABLE `mod_volumefolders` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_widgets` WRITE;
ALTER TABLE `mod_widgets` DISABLE KEYS;
REPLACE INTO `mod_widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,'craft\\widgets\\RecentEntries',1,NULL,'{"section":"*","siteId":"1","limit":10}',1,'2019-08-09 23:26:22','2019-08-09 23:26:22','c1f5cc28-b64a-41d3-bb09-9fbeca9e057e'),
	(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-08-09 23:26:22','2019-08-09 23:26:22','798b2323-a325-49f0-a404-19919fcf35e3'),
	(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-08-09 23:26:22','2019-08-09 23:26:22','7a5ebd36-25a5-40b6-ab45-016e5d151e86'),
	(4,1,'craft\\widgets\\Feed',4,NULL,'{"url":"https://craftcms.com/news.rss","title":"Craft News","limit":5}',1,'2019-08-09 23:26:22','2019-08-09 23:26:22','451c13d1-e7a9-4dba-9f9b-07f59f6477e0');
ALTER TABLE `mod_widgets` ENABLE KEYS;
UNLOCK TABLES;




SET FOREIGN_KEY_CHECKS = @PREVIOUS_FOREIGN_KEY_CHECKS;


