From: David Goulet <dgoulet@efficios.com>
Subject: [RFC] default channel should not be created when a
 channel has been explicitly created
Date: Tue, 07 May 2013 10:56:13 -0400
Message-ID: <5189160D.6080906__16276.6410423957$1367938613$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UZjJV-0002Zb-9t
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 10:56:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 3679BA1D9A
	for <lttng-dev@lists.lttng.org>; Tue,  7 May 2013 14:56:13 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NMxBfiv6gJdh for <lttng-dev@lists.lttng.org>;
	Tue,  7 May 2013 14:56:12 +0000 (UTC)
Received: from 127.0.0.1 (unknown [96.127.207.22])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 4DF77A1D99
	for <lttng-dev@lists.lttng.org>; Tue,  7 May 2013 14:56:12 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi everyone,

I would like to bring your attention on this issue and have everyone's
opinion.

https://bugs.lttng.org/issues/522

LTTng 2.2 is right now in release candidate and the question is if this
should go in right now as a fix or hold on for 2.3? Also, should it be
back ported to 2.1 also?

Thanks!
David
