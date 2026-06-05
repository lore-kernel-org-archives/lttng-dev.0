Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA51CD6E7B
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Jun 2026 19:32:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gXBQn4JXnz1qQF
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1780687939;
	b=akB3cVomXe1SQBVuDou5wp/eoBFhEpN28TSFOAJSgc8C23LovzE/+r4f3YZMifzM6377
	 BuE4r2aJMzVGkerIVAEo6+GTjLtcfSQBihWiwH7xqX7klBJgoAOIHIUx3Gtj2LU/0zcYy
	 68pTDP+JboY+WLCfQmJ9ZamEkGAua5xFoAw87Ww+qC1qqqau+MnEFgfMA2DEdCLFWRDQ+
	 srWS8Gu0HeP+dlu7eqdqVIr0jPUKEtOGFQFTDV+vIAsX2Veo2u/dWq//wczq7jWoFhoQf
	 Fmpeo08HCN0FMytcfMgOingosWiZQL6rPFvDwC9oTbmhW5G/4RdUQJ8CS/gkFg8JOZQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1780687939;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=z6rxjygGlXqgROLoCM+tVE+Yfnw80biLZh/Z8OFPqqA=;
	b=hT2vM4JrO0bKL2fCBwxacu0D3MFZCA8icu7Qt/N1OG7t0g5AaKTm+BFGPIvpbhnJ5Nsv
	 xuoOH6Q0Y2DZ9xc3gXXyqMVyQv1u+D1+hffje9SxFfpJ7iH4QUtzsVBtxPvYMP4M1Cfuj
	 6xgwJ7+VYTNu1K0xu95n1/T3GauviPZmkTY+hEC80qN7T1wGFFxhCRSCjaHO27awU1Q00
	 vxlJyM70y+3l5EszAFkEpJhYsHRgq+cvC+8jq9f82maWwFyRgbwSpRtyByD+ryFuQBpl/
	 FfgFQA/xJQploJ2Dcq8fQhrp3BQXwk96bVZcZ7vq1lv/pF4tEyqhmxXTaGd9mgMvfaQ==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gXBQn4JXnz1qQF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1780687939;
	bh=l/L0fl771Os7LwRcVWTi9fbRERXyBTNF/7m8Imy/1fE=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=o3gKSG/54ozP+wMTOJA1aNhDK0as7vdlPeiebG/5JjL6ZOwDgmiWWQY9K1aOPs2ZW
	 4Rz7EFzPXKrpbtjLFCjZ+CbvpHjueZJh+h6OM+IbASnckeOaU9r6tH0RTvyaFlMpJX
	 UN8IlRvyhhu2BwnmSajVn7NVxFVzBVd85D0yxe2giFEnkqokQ1SvngFaPR50VBa+9J
	 Zf6VVqLEYE8Ec87HOfjIJQlETFzuJxYFkIsGVzTHd0Ax133WRuFJ/JAzkdTfw8dvZb
	 495ndA37K7fDm0pw6l0WvtW+gCvaI72KilduwCF4o1WKc1KXHfxnCcMzUFdZvJ5WDd
	 0kjaB8MTR0vWQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gXBQn4JXnz1qQF;
	Fri,  5 Jun 2026 15:32:17 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gXBQl0jwGz1qQ5
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gXBQl0jwGz1qQ5
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022117.outbound.protection.outlook.com
 [40.107.193.117])
 by lists.lttng.org (Postfix) with ESMTPS id 4gXBQl0jwGz1qQ5
 for <lttng-dev@lists.lttng.org>; Fri,  5 Jun 2026 15:32:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAnGTC5MtMODsy1j6PCF3H+6QxD/OBmKBmyv59b5xHpjuqjPBF7WkQCK2mN/IgJ10XI9TNGE1ypvbCL939N8/RZ7+23wh2sZCWnG57aCnrD+xL5zVFTdI7NqiLL65BX/2lLKv6gPV2YqFsZMhgH5vUPvuoJJ6UAQhurjnUAV2IyUsJwuiADOlIbVZh2N5KgzUd6jG7VVI8jUNpUvICq6FN3EwdIKi34ZabRJ9kKsKbQcePRhT/f9gzNkpgaFs9AzDPuH8stQJWoNL7Nc/We/IEXSQGoCGEtL5TDLeQoHscEG/7FHkJ5YjU4hn9C+pAHLqKqkfPE5Am2irVjbOo34rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skTPnsKlq0hlo4qjvXZmCBDPIVOKJHU0DBMLIyO+uPc=;
 b=MIXKoYjLKMlDi6/iN83CDfnt7/gB4/CT+Cvjomo2rgEGI3qYn4RYjb2UN+dAVmQzxGN1L06UDiu6yfrca6rUUJFoiN8Q+G3OittKDQ2bcTPNmWJeUEqYYQ6vPcmuYC3ASgW4gkdYEiBsPG6vP1wLTFneemq3dMhBAJwoBTahxFqZYSIWenhxGocoMA1i0ccZEKZDfXReFoWNnVgXNkeEzTbF/1oXyHIdHrKVbTCOBmUBEBpjKfhfRX9p6Kbpd4Pk4CMXpKWXJ8B7Iff/3wsL+Jnh/HzoSE+3HZixR0zAdm3dmQOPxSpHG2ofthififOju8Uyw0Ty0UPwxLUX08NvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:167::9)
 by YQBPR01MB11163.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:90::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.5; Fri, 5 Jun 2026
 19:32:09 +0000
Received: from YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b0e8:8334:afbf:9bc]) by YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b0e8:8334:afbf:9bc%3]) with mapi id 15.21.0113.004; Fri, 5 Jun 2026
 19:32:09 +0000
Date: Fri, 5 Jun 2026 15:32:08 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Subject: [RELEASE] LTTng-tools =?iso-8859-1?B?Mi4x?=
 =?iso-8859-1?B?NS4xIC0gUOljaOk=?= Mortel
Message-ID: <aiMkOFJMCVc94my0@efficios.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0394.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::23) To YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:167::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB12074:EE_|YQBPR01MB11163:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e3ffb8-c9fc-44ab-c76d-08dec3392233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: LDNnac5ONBIazQ4bgvKj4vMxnw2dGDZad33jwJiyiElJt8Kaeyi0CmT3glzYhoe8R85D6qCCDpdJYjWH7Wg3NXg9NtOWrVA8Qx/Oi+33og3TiWzHnNCWqQ2ZE/YqW3xODxi6OoFTbemhiCRO3QkQ6mOQTZc7tc982ooufkshBKzPRdonJm5eVY0/Oi+9pxIU8F8Fn3OVhrDrsClowGqgn8MJJIL3OhB4YFUu/KZaFC8lyJz1L328FiBZ1fN8q6BaHiR+VsFvbvKrU4BA8dfTj/cGEbSiZRy35JXzgkyR4wxqvYnOiw3oDl/e1yBg0YDOEhkqRXsUi3dkSIY0ZKMAK5mcRd4dzO76e8xb+URk59qOyyZ5byokkP1W7+LDUXDFN7hzCcndcop7UVHumwWIPv2FjxUM2wDiTAD03zWs93yiYMycNI+1gwCQ/73c5nG92VaE0uQsO5a5b51XFIobimlCbadSBzE6uEvVSeUhayt8ANkxFnbL5pZOLxth72/uWmao+jbunFwllSQa+OGbWMzHLmQLSj+g2hz/bxdmnNeVXafcHhsdSodSQkTRFsdvzPtyCI3T7/ER1dOAhwjc5WCuYTbwI/N2HTFs8T4OwxN9SjfyxGDSsRhzYFLMAlcw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DLKwpjH+kSoMI7BRHPewQ2qp/kuSluoASCjzQOyvWRk+o3S8P3d1m0gEMQ?=
 =?iso-8859-1?Q?uBcCT/jk7T0XEgEcrTfbBR6csX10/K4GdocQ0RCwBhpGqtouX7UsaZ2PSI?=
 =?iso-8859-1?Q?2eY+Q/fWJNRKiWyGkiZIy3lqUUo169yd5T8gZGKGrsBjFLr+06cp/rk8OY?=
 =?iso-8859-1?Q?7Yz8z0aNYzsGGBCTQEzijNpbsqTXuWw5DB05FwWj7juWCA6FWBrPeaCgIh?=
 =?iso-8859-1?Q?Vl1PTXvuuf6Ve/u3/9PBilZNogMp1cXVJZo1u6CrDedlmoh75M5g5rFmrg?=
 =?iso-8859-1?Q?p3A6YQ5AEZz2frJ+f8CgjWXJroniMBZMQ34xGLMqkzUsVTZO4XNe1airDu?=
 =?iso-8859-1?Q?IYzKvL12k8yFU1SEofBA90rsZ2PqkVhVy3mIafDCBHLzmTSeU+SxzRjxzR?=
 =?iso-8859-1?Q?6JZITir29jA50DXNFpHtDGdkkn4+TX+nZi7Be3WfKN+CmqzDOpUTaC89rS?=
 =?iso-8859-1?Q?m6kMHd9nCzSD7XY3cMQSVVwn3DeXIKi7B5wAKCIafpMKn29e4e2gA3LrRM?=
 =?iso-8859-1?Q?fIIdMHTP2TNXGPR99adiMT8n/chyFCmJfDmjzGC6awm5qBbmWtL/l65Pcz?=
 =?iso-8859-1?Q?U91aLtZSRkH/MUvEx5c9RiPHUU68/DFVudg/idbm2nchh5aLHMIcl7xj89?=
 =?iso-8859-1?Q?ZsfvDe6yoWS6WQXikZxhY7cvh5f/l6Yj3Qu8o7gF0U0fd2c3T1sVxRgYST?=
 =?iso-8859-1?Q?9yHnVqYxE1e9I8AX5dSBj9ni0IbpGOVma1qavaESD5j/FAxcRUoUooL7t7?=
 =?iso-8859-1?Q?njmvRN9O6Bv7t2XsZrKBhbZnAKbyy5OlXItDIhN2e9w2FwkPsKvbe8hz0E?=
 =?iso-8859-1?Q?Mwkpqq/HaMkYTkY2rXaJtk0b9puAlIVrKBjiP+mbAcSFHK4FRxQd8eS/oa?=
 =?iso-8859-1?Q?woeMG2m62hdWkp/cofGgvBfqjLVoxkyU0/x7BiWzLDOkUaaxkwQDeNBDLj?=
 =?iso-8859-1?Q?PI9IjycATn0KzakA1Er+LdMmYG0i+N0A88C97CcNAEnvQmJJkzge6b1ZU5?=
 =?iso-8859-1?Q?RTJSsmN66eiBVJM8kU2gPMdzE2Ky4QgpGar/Vos6627owdrVZl/ZNUx23e?=
 =?iso-8859-1?Q?fBmn2E5oi51rR1GOHqICFAdzfMXPGO98yX6QgPp6ysHm7zqHCg7Jp3rsY3?=
 =?iso-8859-1?Q?+N2ZiwwT+tmenPfE/jSMrBXSg003l07IfE62rWY1beqIuj5IaUiQ2jJk0J?=
 =?iso-8859-1?Q?2lXKPurXAmOkw6+1Cfyf8fkEYftJA8nyqJHPXtAcLlBKc1KigiE6d2nP9f?=
 =?iso-8859-1?Q?p+SyeSUcepUrG21aMiv8WoLetXNzlOqKbQ5+nVeMpJM/8Xbh84i/KVzO6z?=
 =?iso-8859-1?Q?LAwDN1pw5wWloOI6drTfsu4Zjn6+n3/WRFGGdCq5h5bFwWjONZn+PSUzqH?=
 =?iso-8859-1?Q?fZneZBpfMrrcYV5B0UthwCHylrCjHKyf4ZMrzptRML5jPw6z8LskGQHyAT?=
 =?iso-8859-1?Q?uot+aP42Iq3mFWWUl6j8a0sV91JlCuLdiQSVJMB4SIWD9sOWJQYDn7B5yX?=
 =?iso-8859-1?Q?0HvPfWRqkOzU9EwAO4Zvh7U+w4HJz8umPER8ox7UESK6UfLHxarqIgA5lV?=
 =?iso-8859-1?Q?ZVODTld/fipnDOO+yrnvYiYy1awanaffJCbxO7J7DE0UFZ/nQAiog+7zKy?=
 =?iso-8859-1?Q?M75dxlCsZCbVt56ItYJLZBcFkglr3+dumlX9yhaHvVq1U1Ele+xYzmWX1c?=
 =?iso-8859-1?Q?93A0dJNmAGQZQ7fZU3YI6mej1sMnYf/g6F+dRVDdbGQOqp84fQCMgBR+6J?=
 =?iso-8859-1?Q?Wtxz/qCBF4SydzmwlYXnPyTPJU13dGLnAxPdyCY5StNx1p1j50KRMrgln3?=
 =?iso-8859-1?Q?Wd+D4EqjsA=3D=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e3ffb8-c9fc-44ab-c76d-08dec3392233
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 19:32:08.8377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aN52XzMAnFSujcC5uJxEGELOAy+Yaoeb2xkMAA0tyXQN/YR5r3rIwZ5ihoTCCBlJP1E80woCNrKMhL9vQtbsCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB11163
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the first bug-fix release of LTTng-tools 2.15 -
Péché Mortel. This release addresses a number of issues listed below.

2026-06-05 lttng-tools 2.15.1 (National Fish and Chip Day)
        * Fix: tests: Set mip version for python defined bt graphs explicitly
        * Fix: Include 32-bit kernel trace expect file in dist
        * build: Fix api-doc help string indentation
        * build: Fix enable-werror help string indentation
        * Fix: various typos in license identifiers
        * tests: fix preload of liblttng-ust-ctl-fuzz.so with '-Wl,-z,now'
        * tests: Handle WaitTraceTestApplications that crash early with no stderr
        * Fix: sessiond: abort when loading an agent session configuration
        * Fix: tests: missing shell quoting of filter expressions in test harness
        * Fix: tests: swapped allowed value types for process attribute trackers
        * Fix: relayd: wrong session id used in trace chunk existence check
        * Fix: lttng: truncated session name when it contains spaces
        * common: Split CPU mask parsing from reading
        * Fix: parsing CPU mask with no separators
        * Fix: common: Improve cpu mask error checking
        * common: Escape newlines when printing CPU mask
        * tests: Disable watchdog-timer for blocking tests
        * sessiond: Fix: Deadlock when handling notification overflow
        * tests: add test_condition to the unit test list
        * tests: add notification/test_rotation to the regression test list
        * tests: Fix rotation notification test when tmpdir contains symlink
        * Fix: tests: race in rotation notification test
        * Fix: tests: undefined CHANNEL_NAME in rotation notification test
        * Fix: relayd: live viewer reads wrong chunk after per-PID clear
        * Fix: lttng: vague error reporting in reclaim-memory command
        * Fix: consumerd: pause testpoint not re-evaluated after poll()
        * consumerd: Fix segfault when starting metadata switch timer
        * tests: Check kernel release to determine delay table parameters
        * Fix: tests: consumer pause testpoint FIFO EOF mishandled as error
        * Fix: tests: serial runner produces empty log files for hanging tests
        * tests: Fix platform uname split when release contains more periods
        * Fix: common: uri_compare compares uninitialized union tail
        * Fix: common: drop :: qualifier on *_CLOEXEC for musl compatibility
        * doc: lttng-view(1): remove non-existent '--session' option
        * lttng: handle popt parsing errors
        * fix: '-Wsuggest-override' only valid for C++ warnings
        * Fix: handle failures to find pid cmdline
        * Fix: tests: Do not use both  `-p` and `-t` together for mktemp
        * Fix: common: lockfile fd leaks into consumerd via fork+exec
        * Fix: sessiond: default kernel probe list missing 9p and dma-fence
        * tests: fix: lttng-sessiond abort when using libkmod
        * Fix: common: lttng client abort when serializing rotate-session action
        * Fix: common: stop-session action serialized as start-session in MI
        * Fix: common: MI XSD names start/stop-session actions without "_session"
        * Fix: common: MI XSD rejects add-context per-context success element
        * Fix: common: MI XSD names snapshot record action "record-output"
        * Fix: lttng: reclaim-memory MI emits generic "channels" element
        * Fix: common: enable-event MI emits duplicate exclusions element

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.15.1.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.15.1.tar.bz2.asc
