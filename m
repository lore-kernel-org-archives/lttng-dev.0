From: =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien+lttng@versatic.net>
Subject: Add support of CTF structure global type
Date: Wed, 26 Mar 2014 10:55:09 -0400
Message-ID: <1395845712-18498-1-git-send-email-gbastien+lttng__34552.088919054$1395845755$gmane$org@versatic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien+lttng@versatic.net>) id 1WSpEh-0000le-EY
	for lttng-dev@lists.lttng.org; Wed, 26 Mar 2014 10:55:24 -0400
Received: from wilbrod.dorsal.polymtl.ca ([132.207.72.9])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id s2QEtMqD003733
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Wed, 26 Mar 2014 10:55:23 -0400
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

The following patch series in LTTng-Tools add support of the named CTF
structure global type. It goes along with a patch series in LTTng-ust.

It is built above the CTF enumerations patches proposed earlier adn being
staged in Mathieu Desnoyers's development branch here:
https://github.com/compudj/lttng-tools-dev/tree/ust-enum
