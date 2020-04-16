From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Subject: [RELEASE] LTTng-tools 2.10.11 - KeKriek
Date: Thu, 16 Apr 2020 18:00:35 -0400
Message-ID: <20200416220035.GB61343@gmail.com>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by lists.lttng.org (Postfix) with ESMTPS id 493CpJ3gp0z1gWW
 for <lttng-dev@lists.lttng.org>; Thu, 16 Apr 2020 18:00:39 -0400 (EDT)
Received: by mail-qv1-f46.google.com with SMTP id v18so2900369qvx.9
 for <lttng-dev@lists.lttng.org>; Thu, 16 Apr 2020 15:00:39 -0700 (PDT)
Received: from gmail.com (192-222-251-19.qc.cable.ebox.net. [192.222.251.19])
 by smtp.gmail.com with ESMTPSA id
 y9sm16377606qtc.12.2020.04.16.15.00.37
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 15:00:37 -0700 (PDT)
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

The eleventh bug-fix release of LTTng-Tools 2.10 - KeKriek has just
been released. This release addresses a number of issues listed below.

2020-04-16 lttng-tools 2.10.11 (National Eggs Benedict Day)
	* Fix: common: add `void` parameter to log_add_time declaration
	* Fix: lttng-list: don't warn when the kernel domain has no channels
	* Fix: sessiond: occasional badfd error on repeated SIGTERM
	* Fix: lttng: incorrect domain list printed when no domain is provided
	* Silence `POSIX Yacc` warnings
	* Tests: Fix: `wait_on_file()` returns too early
	* Fix: Tests: utils.sh: fix unbound variable
	* Tests: Fix typo: registerd -> registered
	* Fix: force the use of our _FORTIFY_SOURCE definition

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.10.11.tar.bz2

GPG sig:
https://lttng.org/files/lttng-tools/lttng-tools-2.10.11.tar.bz2.asc
