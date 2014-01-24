From: =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien+lttng@versatic.net>
Subject: LTTng-tools: Add support of named metadata and CTF
	enumerations
Date: Fri, 24 Jan 2014 15:07:21 -0500
Message-ID: <1390594045-7556-1-git-send-email-gbastien+lttng__4403.01811690933$1390594907$gmane$org@versatic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien+lttng@versatic.net>) id 1W6n2S-0002zr-4t
	for lttng-dev@lists.lttng.org; Fri, 24 Jan 2014 15:07:45 -0500
Received: from wilbrod.dorsal.polymtl.ca ([132.207.72.9])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id s0OK7dTj020293
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Fri, 24 Jan 2014 15:07:39 -0500
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

The following patch series in LTTng-tools add support of named metadata 
in tracepoints, and add the statedump in metadata of named CTF
enumerations.

This series goes with another patch series in LTTng-ust. Patch 1 works
with LTTng-ust master, but the other patches require LTTng-ust's series
patch 5.
