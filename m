From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.10.9 - KeKriek
Date: Fri, 18 Oct 2019 23:55:15 -0400
Message-ID: <20191019035515.GB5729__37606.8297818833$1571457392$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by lists.lttng.org (Postfix) with ESMTPS id 46w8F55D4tzq6l
 for <lttng-dev@lists.lttng.org>; Fri, 18 Oct 2019 23:55:21 -0400 (EDT)
Received: by mail-qt1-f175.google.com with SMTP id u22so12102216qtq.13
 for <lttng-dev@lists.lttng.org>; Fri, 18 Oct 2019 20:55:21 -0700 (PDT)
Received: from gmail.com (192-222-251-19.qc.cable.ebox.net. [192.222.251.19])
 by smtp.gmail.com with ESMTPSA id
 n4sm160749qtr.58.2019.10.18.20.55.18 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 20:55:19 -0700 (PDT)
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

The ninth bug-fix release of LTTng-Tools 2.10 - KeKriek has just been
released. This release addresses a number of issues listed below.

2019-10-17 lttng-tools 2.10.9 (Wear Something Gaudy Day)
	* Fix: sessiond: TOCTOU error on save of session configuration
	* Fix: tests: replace truncation-prone logging helper

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.10.9.tar.bz2

GPG sig:
https://lttng.org/files/lttng-tools/lttng-tools-2.10.9.tar.bz2.asc
