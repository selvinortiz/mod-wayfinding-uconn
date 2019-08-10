#
# SQL Export
# Created by Querious (201067)
# Created: August 9, 2019 at 7:21:58 PM CDT
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `mod_content_siteId_idx` (`siteId`),
  KEY `mod_content_title_idx` (`title`),
  CONSTRAINT `mod_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `mod_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mod_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `mod_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;


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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


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
REPLACE INTO `mod_content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,NULL,'2019-08-06 14:20:26','2019-08-10 00:10:29','36067336-ac15-40c4-a74f-a4582312ed8d'),
	(2,2,1,'Marketing','2019-08-10 00:01:39','2019-08-10 00:01:39','92699c86-749f-4d1a-85b7-1cc81e025ceb'),
	(3,3,1,'Design','2019-08-10 00:02:04','2019-08-10 00:02:04','3c64afc6-e108-4200-bc43-cafc218a97f6'),
	(4,4,1,'Development','2019-08-10 00:02:13','2019-08-10 00:02:13','06bcf1ab-8654-4eae-8297-ad4df3c601b8'),
	(5,5,1,'Information Technology','2019-08-10 00:02:27','2019-08-10 00:02:27','793a10a5-65a1-4006-a8f8-045633982710');
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
	(1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2019-08-06 14:20:25','2019-08-10 00:10:28',NULL,'09d16a69-77d3-44ee-99c5-4376ccdc035e'),
	(2,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-10 00:01:39','2019-08-10 00:01:39',NULL,'6773627c-02b1-4b68-9d7e-f8fcd3ffeb20'),
	(3,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-10 00:02:04','2019-08-10 00:02:04',NULL,'b5cc260f-bbd5-46ed-b02e-c88f19ad0a9b'),
	(4,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-10 00:02:13','2019-08-10 00:02:13',NULL,'a5257512-9480-414c-865f-ed7a51981cf0'),
	(5,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-08-10 00:02:27','2019-08-10 00:02:27',NULL,'68bf4db0-a42c-4c3f-bd25-9b22da1dc61d');
ALTER TABLE `mod_elements` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_elements_sites` WRITE;
ALTER TABLE `mod_elements_sites` DISABLE KEYS;
REPLACE INTO `mod_elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,NULL,NULL,1,'2019-08-06 14:20:26','2019-08-06 14:20:26','40db421f-54e1-4799-a4ee-b5c3f57e46e4'),
	(2,2,1,'marketing','departments/marketing',1,'2019-08-10 00:01:39','2019-08-10 00:01:48','31bc7be4-0d18-4726-8774-aa946ea49f58'),
	(3,3,1,'design','departments/design',1,'2019-08-10 00:02:04','2019-08-10 00:02:32','821b2bac-2fa0-4718-9b49-af26c6364ee8'),
	(4,4,1,'development','departments/development',1,'2019-08-10 00:02:13','2019-08-10 00:02:14','2209a95d-010e-4c4e-8ab2-aa5c09018d51'),
	(5,5,1,'information-technology','departments/information-technology',1,'2019-08-10 00:02:27','2019-08-10 00:02:27','dfbbf558-73fd-410a-ade9-f98244633847');
ALTER TABLE `mod_elements_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldlayouts` WRITE;
ALTER TABLE `mod_fieldlayouts` DISABLE KEYS;
REPLACE INTO `mod_fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,'craft\\elements\\MatrixBlock','2019-08-09 23:44:41','2019-08-09 23:44:41','2019-08-09 23:49:33','b0f6608f-9d59-44ff-984f-b5b93bb4c776');
ALTER TABLE `mod_fieldlayouts` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_entrytypes` WRITE;
ALTER TABLE `mod_entrytypes` DISABLE KEYS;
REPLACE INTO `mod_entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,1,NULL,'People','people',1,'Title',NULL,1,'2019-08-09 23:56:27','2019-08-09 23:56:27',NULL,'768985c8-5d07-4ad1-a7a3-ab74f182d220'),
	(2,2,NULL,'Campus','campus',1,'Name','',1,'2019-08-09 23:57:22','2019-08-10 00:00:27',NULL,'f541d666-e7e1-45b5-a776-7bbdfa66e29c'),
	(3,2,NULL,'Building','building',1,'Name','',2,'2019-08-09 23:59:04','2019-08-10 00:00:45',NULL,'f6e43059-9031-4777-a162-591a7fee0760'),
	(4,2,NULL,'Floor','floor',1,'Number','',3,'2019-08-09 23:59:48','2019-08-09 23:59:48',NULL,'99871494-af8f-4f42-bdb0-3e519fedf271'),
	(5,2,NULL,'Room','room',1,'Number','',4,'2019-08-10 00:00:09','2019-08-10 00:00:09',NULL,'8c221645-84c1-4d99-b523-c089ef81a347');
ALTER TABLE `mod_entrytypes` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_entries` WRITE;
ALTER TABLE `mod_entries` DISABLE KEYS;
ALTER TABLE `mod_entries` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldgroups` WRITE;
ALTER TABLE `mod_fieldgroups` DISABLE KEYS;
ALTER TABLE `mod_fieldgroups` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_fieldlayouttabs` WRITE;
ALTER TABLE `mod_fieldlayouttabs` DISABLE KEYS;
REPLACE INTO `mod_fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,'Content',1,'2019-08-09 23:44:42','2019-08-09 23:44:42','c5a68ed3-807f-4cf6-a77c-3f9fb33ab533');
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


LOCK TABLES `mod_info` WRITE;
ALTER TABLE `mod_info` DISABLE KEYS;
REPLACE INTO `mod_info` (`id`, `version`, `schemaVersion`, `maintenance`, `config`, `configMap`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,'3.2.9','3.2.16',0,'{"fieldGroups":[],"siteGroups":{"ff79c85e-c1a7-4b70-b7f9-8d73726d5506":{"name":"ModCore"}},"sites":{"c1732a15-3da9-4623-9804-bb1538425f67":{"baseUrl":"$DEFAULT_SITE_URL","handle":"default","hasUrls":true,"language":"en-US","name":"ModCore","primary":true,"siteGroup":"ff79c85e-c1a7-4b70-b7f9-8d73726d5506","sortOrder":1}},"email":{"fromEmail":"selvin@modcreativeinc.com","fromName":"Mod Creative","template":"","transportType":"craft\\\\mail\\\\transportadapters\\\\Sendmail","transportSettings":null},"system":{"edition":"pro","name":"ModCore","live":true,"schemaVersion":"3.2.16","timeZone":"America/Chicago"},"users":{"requireEmailVerification":true,"allowPublicRegistration":false,"defaultGroup":null,"photoVolumeUid":null,"photoSubpath":""},"dateModified":1565396363,"plugins":{"redactor":{"edition":"standard","enabled":true,"schemaVersion":"2.3.0"}},"fields":[],"matrixBlockTypes":[],"categoryGroups":{"32a2dc05-2af1-4855-8252-4622cd2a8f56":{"name":"Departments","handle":"departments","structure":{"uid":"d6205b4f-1b8a-4afe-a3f5-728fac8df0e7","maxLevels":1},"siteSettings":{"c1732a15-3da9-4623-9804-bb1538425f67":{"hasUrls":true,"uriFormat":"departments/{slug}","template":""}}}},"sections":{"55acf63b-b2c2-454b-9842-fdecf05be856":{"name":"People","handle":"people","type":"structure","enableVersioning":false,"propagationMethod":"all","siteSettings":{"c1732a15-3da9-4623-9804-bb1538425f67":{"enabledByDefault":true,"hasUrls":true,"uriFormat":"people/{slug}","template":"people/_person"}},"structure":{"uid":"99a5afbe-485a-4886-8da1-2070ffec24b6","maxLevels":1},"entryTypes":{"768985c8-5d07-4ad1-a7a3-ab74f182d220":{"name":"People","handle":"people","hasTitleField":true,"titleLabel":"Title","titleFormat":null,"sortOrder":1}}},"84c2ec09-b2d9-4812-addd-abc792357963":{"name":"Places","handle":"places","type":"structure","enableVersioning":false,"propagationMethod":"all","siteSettings":{"c1732a15-3da9-4623-9804-bb1538425f67":{"enabledByDefault":true,"hasUrls":true,"uriFormat":"{parent.uri ?? \'places\'}/{slug}","template":"places/_place"}},"structure":{"uid":"eee91aaf-9337-42be-81fa-195c750c1a64","maxLevels":5},"entryTypes":{"f541d666-e7e1-45b5-a776-7bbdfa66e29c":{"name":"Campus","handle":"campus","hasTitleField":true,"titleLabel":"Name","titleFormat":"","sortOrder":1},"f6e43059-9031-4777-a162-591a7fee0760":{"name":"Building","handle":"building","hasTitleField":true,"titleLabel":"Name","titleFormat":"","sortOrder":2},"99871494-af8f-4f42-bdb0-3e519fedf271":{"name":"Floor","handle":"floor","hasTitleField":true,"titleLabel":"Number","titleFormat":"","sortOrder":3},"8c221645-84c1-4d99-b523-c089ef81a347":{"name":"Room","handle":"room","hasTitleField":true,"titleLabel":"Number","titleFormat":"","sortOrder":4}}}},"volumes":{"8d7880f3-e3e2-409a-866e-6aa2b3a0f616":{"name":"Uploads","handle":"uploads","type":"craft\\\\volumes\\\\Local","hasUrls":true,"url":"@web/uploads","settings":{"path":"@webroot/uploads"},"sortOrder":1},"9b3e91a4-dbdb-4640-9d8e-028f11cfc6ed":{"name":"System","handle":"system","type":"craft\\\\volumes\\\\Local","hasUrls":true,"url":"@web/system","settings":{"path":"@webroot/system"},"sortOrder":2}}}','[]','H9QNSwgT9v2C','2019-08-06 14:20:22','2019-08-06 14:20:22','5dd55b49-beeb-41cf-a1b6-0eab9e39f954');
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
	(2,'redactor','2.3.3.2','2.3.0','unknown',NULL,'2019-08-10 00:05:34','2019-08-10 00:05:34','2019-08-10 00:17:12','b2c3b002-b693-4e29-bbb9-7c845e233fe2');
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
	('7751e3cd','@lib/jquery.payment'),
	('7af9bb58','@bower/jquery/dist'),
	('80c614ed','@craft/web/assets/recententries/dist'),
	('80d86ce3','@craft/web/assets/userpermissions/dist'),
	('82b7baa9','@craft/web/assets/utilities/dist'),
	('84b1aaff','@lib/d3'),
	('8a148aae','@lib/picturefill'),
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
	(5,'title',0,1,' information technology ');
ALTER TABLE `mod_searchindex` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sections` WRITE;
ALTER TABLE `mod_sections` DISABLE KEYS;
REPLACE INTO `mod_sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagationMethod`, `previewTargets`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES 
	(1,2,'People','people','structure',0,'all',NULL,'2019-08-09 23:56:26','2019-08-09 23:56:26',NULL,'55acf63b-b2c2-454b-9842-fdecf05be856'),
	(2,3,'Places','places','structure',0,'all',NULL,'2019-08-09 23:57:21','2019-08-10 00:00:45',NULL,'84c2ec09-b2d9-4812-addd-abc792357963');
ALTER TABLE `mod_sections` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sections_sites` WRITE;
ALTER TABLE `mod_sections_sites` DISABLE KEYS;
REPLACE INTO `mod_sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,1,1,'people/{slug}','people/_person',1,'2019-08-09 23:56:26','2019-08-09 23:56:26','749d1a60-2ece-45cd-84d2-a4e955c8ac44'),
	(2,2,1,1,'{parent.uri ?? \'places\'}/{slug}','places/_place',1,'2019-08-09 23:57:22','2019-08-10 00:00:45','72169887-f4ad-46ee-80ff-c05595fe99ae');
ALTER TABLE `mod_sections_sites` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sequences` WRITE;
ALTER TABLE `mod_sequences` DISABLE KEYS;
ALTER TABLE `mod_sequences` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mod_sessions` WRITE;
ALTER TABLE `mod_sessions` DISABLE KEYS;
REPLACE INTO `mod_sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`) VALUES 
	(1,1,'1J5rpIMco3sWMhhCmpjq14Wb45Uq3KTS2zPXpZHcooRO2msdIA5CJlC-1_Ef3IgM7ZfI9FNlEMLtGTAtyFvIUnmNVwmn1956XNgx','2019-08-09 23:26:18','2019-08-10 00:20:36','169c1e21-cc3f-4fe4-80b1-e3deb882a6d6');
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
	(5,1,5,1,8,9,1,'2019-08-10 00:02:27','2019-08-10 00:02:32','812b69d0-6023-45e9-a257-005507a01fa1');
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
	(1,'admin',NULL,'Mod','Creative','selvin@modcreativeinc.com','$2y$13$ep9C33aUww5.sOWqTZK47.WLmCWCycFK33Mkh5ZveDxuZLOT12ska',1,0,0,0,'2019-08-09 23:26:19',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-08-06 14:20:27','2019-08-06 14:20:27','2019-08-10 00:10:29','d8e7e3d5-0f52-42b1-8164-8171907c6572');
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


