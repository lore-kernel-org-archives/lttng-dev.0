From: =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien+lttng@versatic.net>
Subject: LTTng-ust: Add support of named metadata and CTF
	enumerations
Date: Fri, 24 Jan 2014 15:04:38 -0500
Message-ID: <1390593885-7463-1-git-send-email-gbastien+lttng__44403.2490057454$1390593975$gmane$org@versatic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien+lttng@versatic.net>) id 1W6n00-0002wl-Dg
	for lttng-dev@lists.lttng.org; Fri, 24 Jan 2014 15:05:13 -0500
Received: from wilbrod.dorsal.polymtl.ca ([132.207.72.9])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id s0OK57rv018860
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Fri, 24 Jan 2014 15:05:08 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The following patch series in LTTng-ust add support of named CTF metadata in
tracepoints, and add support of enumerations fields.

This series goes with another patch series in LTTng-tools. This series'
patch 5 needs the LTTng-tools patch series.

Filters do not work yet for enumeration fields.
