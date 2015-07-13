From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [RELEASE] LTTng-analyses v0.3
Date: Mon, 13 Jul 2015 19:05:38 -0400
Message-ID: <55A44442.1070008__27516.7174092077$1436828799$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEmnB-0002hT-6I
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 19:05:49 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, diamon-discuss@lists.linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

Hi everyone,

I am glad to announce the third release of the lttng-analyses project [1] !

This project is a collection of tools to extract metrics and
higher-level informations from LTTng kernel traces.

This release contains a reorganization from Michael Jeanson in the
architecture of the Python modules. Thanks to this work, we can now
easily create and distribute clean Python packages.

As of now, the packages are available with pip [2]. Packages for Debian
and Ubuntu will be available in a few days.

If your project is already importing the Python modules we exposed in
the previous release, you just have to update your imports, no API/code
change besides that.

It has been two consecutive releases consisting of code re-architecture,
you can now expect new analyses and views to enter in the coming releases.

As always, we appreciate all kinds of feedback, use-cases and real-world
experiences, so please test it and let us know what you think about it.

Thanks,

Julien

[1] https://github.com/lttng/lttng-analyses
[2]
https://pypi.python.org/pypi?:action=display&name=lttnganalyses&version=0.3.0
