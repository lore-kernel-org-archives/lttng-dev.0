From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-tools 2.11.2 - Lafontaine
Date: Wed, 12 Feb 2020 14:49:10 -0500
Message-ID: <20200212194910.GA7354@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by lists.lttng.org (Postfix) with ESMTPS id 48HqwB4wTPz14m4
 for <lttng-dev@lists.lttng.org>; Wed, 12 Feb 2020 14:49:14 -0500 (EST)
Received: by mail-qv1-f44.google.com with SMTP id y2so1477670qvu.13
 for <lttng-dev@lists.lttng.org>; Wed, 12 Feb 2020 11:49:14 -0800 (PST)
Received: from gmail.com (192-222-181-218.qc.cable.ebox.net. [192.222.181.218])
 by smtp.gmail.com with ESMTPSA id p19sm50584qte.81.2020.02.12.11.49.11
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 11:49:12 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

The second bug-fix release of LTTng-tools 2.11 - Lafontaine has just
been released. This release addresses a number of issues listed below.

2020-02-12 lttng-tools 2.11.2 (Hug Day)
	* Fix: sessiond: check for lttng-modules ABI 2.1 rather than 2.8
	* Tests: Fix: `wait_on_file()` returns too early
	* Fix: Tests: utils.sh: fix unbound variable
	* Tests: Fix typo: registerd -> registered
	* Typo: 'toogle' -> 'toggle'
	* Fix: force the use of our _FORTIFY_SOURCE definition

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.2.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.2.tar.bz2.asc
