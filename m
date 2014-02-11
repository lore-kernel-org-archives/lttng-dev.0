From: =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien+lttng@versatic.net>
Subject: LTTng-tools: Add support of global types and CTF
	enumerations
Date: Tue, 11 Feb 2014 16:40:47 -0500
Message-ID: <1392154852-31268-1-git-send-email-gbastien+lttng__14692.0613515706$1392155579$gmane$org@versatic.net>
References: <1390594045-7556-1-git-send-email-gbastien+lttng@versatic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien+lttng@versatic.net>) id 1WDL4m-0005qJ-5g
	for lttng-dev@lists.lttng.org; Tue, 11 Feb 2014 16:41:13 -0500
Received: from wilbrod.dorsal.polymtl.ca ([132.207.72.9])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id s1BLf6oJ023481
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Tue, 11 Feb 2014 16:41:07 -0500
In-Reply-To: <1390594045-7556-1-git-send-email-gbastien+lttng@versatic.net>
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

I made the corrections to the patches and added a regression test for events
with tracepoints using global type declarations.
