#
# SQL Export
# Created by Querious (201067)
# Created: August 27, 2019 at 9:48:27 PM CDT
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
DROP TABLE IF EXISTS `mod_matrixblocks`;
DROP TABLE IF EXISTS `mod_matrixblocktypes`;
DROP TABLE IF EXISTS `mod_info`;
DROP TABLE IF EXISTS `mod_gqlschemas`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `mod_content_siteId_idx` (`siteId`),
  KEY `mod_content_title_idx` (`title`),
  CONSTRAINT `mod_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `mod_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `mod_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




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
ALTER TABLE `mod_categorygroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_categories` WRITE;
ALTER TABLE `mod_categories` DISABLE KEYS;
ALTER TABLE `mod_categories` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_categorygroups_sites` WRITE;
ALTER TABLE `mod_categorygroups_sites` DISABLE KEYS;
ALTER TABLE `mod_categorygroups_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_content` WRITE;
ALTER TABLE `mod_content` DISABLE KEYS;
REPLACE INTO `mod_content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,NULL,'2019-08-28 02:21:49','2019-08-28 02:21:49','1c63f9b5-b21d-476b-bd73-76ec29844ac4');
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
ALTER TABLE `mod_drafts` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_elementindexsettings` WRITE;
ALTER TABLE `mod_elementindexsettings` DISABLE KEYS;
ALTER TABLE `mod_elementindexsettings` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_elements` WRITE;
ALTER TABLE `mod_elements` DISABLE KEYS;
REPLACE INTO `mod_elements` (`id`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2019-08-28 02:21:48','2019-08-28 02:21:48',NULL,'0b8caecd-3395-4ee0-95ab-cfa1ab8b4267');
ALTER TABLE `mod_elements` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_elements_sites` WRITE;
ALTER TABLE `mod_elements_sites` DISABLE KEYS;
REPLACE INTO `mod_elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,NULL,NULL,1,'2019-08-28 02:21:49','2019-08-28 02:21:49','c441353b-7d29-44a4-a6f1-7e920c9082eb');
ALTER TABLE `mod_elements_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldlayouts` WRITE;
ALTER TABLE `mod_fieldlayouts` DISABLE KEYS;
ALTER TABLE `mod_fieldlayouts` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_entrytypes` WRITE;
ALTER TABLE `mod_entrytypes` DISABLE KEYS;
ALTER TABLE `mod_entrytypes` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_entries` WRITE;
ALTER TABLE `mod_entries` DISABLE KEYS;
ALTER TABLE `mod_entries` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldgroups` WRITE;
ALTER TABLE `mod_fieldgroups` DISABLE KEYS;
REPLACE INTO `mod_fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,'Common','2019-08-28 02:21:46','2019-08-28 02:21:46','d6996700-c76b-4630-96d4-2e535eefff9a');
ALTER TABLE `mod_fieldgroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldlayouttabs` WRITE;
ALTER TABLE `mod_fieldlayouttabs` DISABLE KEYS;
ALTER TABLE `mod_fieldlayouttabs` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fields` WRITE;
ALTER TABLE `mod_fields` DISABLE KEYS;
ALTER TABLE `mod_fields` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldlayoutfields` WRITE;
ALTER TABLE `mod_fieldlayoutfields` DISABLE KEYS;
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
	(1,'3.3.0.1','3.3.3',0,'{"fieldGroups":{"d6996700-c76b-4630-96d4-2e535eefff9a":{"name":"Common"}},"siteGroups":{"505c19d2-64bf-4ead-a137-ee5848e9f3c3":{"name":"ModCore"}},"sites":{"86cb8f50-93a8-4e48-b08a-a74fc1941e97":{"baseUrl":"$DEFAULT_SITE_URL","handle":"default","hasUrls":true,"language":"en-US","name":"ModCore","primary":true,"siteGroup":"505c19d2-64bf-4ead-a137-ee5848e9f3c3","sortOrder":1}},"email":{"fromEmail":"selvin@modcreativeinc.com","fromName":"ModCore","transportType":"craft\\\\mail\\\\transportadapters\\\\Sendmail"},"system":{"edition":"solo","name":"ModCore","live":true,"schemaVersion":"3.3.3","timeZone":"America/Los_Angeles"},"users":{"requireEmailVerification":true,"allowPublicRegistration":false,"defaultGroup":null,"photoVolumeUid":null,"photoSubpath":""},"dateModified":1566960449,"plugins":{"redactor":{"edition":"standard","enabled":true,"schemaVersion":"2.3.0"},"architect":{"edition":"standard","enabled":true,"schemaVersion":"2.0.0"},"smart-fields":{"edition":"standard","enabled":true,"schemaVersion":"1.0.0"},"hidden-fields":{"edition":"standard","enabled":true,"schemaVersion":"1.0.0"}}}','[]','cHdH9p0HrDLv','2019-08-28 02:21:45','2019-08-28 02:21:45','a84e761f-1b53-462a-8dbc-8762647328eb');
ALTER TABLE `mod_info` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_matrixblocktypes` WRITE;
ALTER TABLE `mod_matrixblocktypes` DISABLE KEYS;
ALTER TABLE `mod_matrixblocktypes` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_matrixblocks` WRITE;
ALTER TABLE `mod_matrixblocks` DISABLE KEYS;
ALTER TABLE `mod_matrixblocks` ENABLE KEYS;
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
	('3362dd45','@lib/xregexp'),
	('390e99cf','@lib/selectize'),
	('452e57a2','@lib/fabric'),
	('5068839c','@lib/garnishjs'),
	('63d5941a','@lib/d3'),
	('6ad48889','@lib/jquery-touch-events'),
	('6d70b44b','@lib/picturefill'),
	('7598b5b5','@lib/fileupload'),
	('816f5755','@app/web/assets/login/dist'),
	('8551422b','@app/web/assets/cp/dist'),
	('befce414','@lib/jquery-ui'),
	('ce4a2339','@lib/element-resize-detector'),
	('dad51332','@pennebaker/architect/assetbundles/indexcpsection/dist'),
	('e1da88cc','@bower/jquery/dist'),
	('e72a00ba','@app/web/assets/utilities/dist'),
	('ec72d059','@lib/jquery.payment'),
	('f0557fb1','@lib/velocity');
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
ALTER TABLE `mod_sections` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sections_sites` WRITE;
ALTER TABLE `mod_sections_sites` DISABLE KEYS;
ALTER TABLE `mod_sections_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sequences` WRITE;
ALTER TABLE `mod_sequences` DISABLE KEYS;
ALTER TABLE `mod_sequences` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sessions` WRITE;
ALTER TABLE `mod_sessions` DISABLE KEYS;
REPLACE INTO `mod_sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,'1qcB7pcR_m-XMTEVG-z7EMJDXw-q0ZL4VVZKLKsqKJZIXZ9nbc3vq_1aRqpUv82OnMRkwaydP8Ya6JJF6wNy1ptQOQKnIZMSjBMw','2019-08-28 02:32:04','2019-08-28 02:45:09','f3fc412e-e578-46d7-9817-5f635f1046a8');
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
ALTER TABLE `mod_structures` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_structureelements` WRITE;
ALTER TABLE `mod_structureelements` DISABLE KEYS;
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
	(1,'admin',NULL,NULL,NULL,'selvin@modcreativeinc.com','$2y$13$QzzRZg8BfdxYFBXa/gK8Yu4FlHkpgVJrvQaTmmz.BMxWj2Y11pf0m',1,0,0,0,'2019-08-28 02:32:04',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,0,'2019-08-28 02:21:50','2019-08-28 02:21:50','2019-08-28 02:32:05','46fa75a4-dcda-4c9a-8599-a2e00d875f28');
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
ALTER TABLE `mod_volumes` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_volumefolders` WRITE;
ALTER TABLE `mod_volumefolders` DISABLE KEYS;
ALTER TABLE `mod_volumefolders` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_widgets` WRITE;
ALTER TABLE `mod_widgets` DISABLE KEYS;
ALTER TABLE `mod_widgets` ENABLE KEYS;
UNLOCK TABLES;




SET FOREIGN_KEY_CHECKS = @PREVIOUS_FOREIGN_KEY_CHECKS;


