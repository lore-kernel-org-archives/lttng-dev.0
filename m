From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: Centos 6.x packages ?
Date: Thu, 27 Feb 2014 00:02:43 -0500
Message-ID: <1393477363.530ec6f31af30__24754.5474129312$1393477395$gmane$org@www.imp.polymtl.ca>
References: <CAMAQhePXxjfKHVrBz0yipy1JgOt1qV00UFFS6sojaHRsGuou5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <suchakrapani.sharma@polymtl.ca>) id 1WIt7M-0001wk-Ln
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 00:02:45 -0500
In-Reply-To: <CAMAQhePXxjfKHVrBz0yipy1JgOt1qV00UFFS6sojaHRsGuou5w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eduardo Silva <edsiper@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

> is there any Centos 6.x packages around ?

I don't think there are 'official' CentOS 6 packages. There are, however,
packages built for EPEL 6. Have a look at [1] and [2] for lttng-tools and
lttng-ust. Find other lttng related packages on the package app [3]. So, you
have 2 choices now:

1. You can maybe try to enable EPEL repos on CentOS 6. Refer [4]. This should
generally work.
2. You can also rebuild packages from the source RPMs [5]. This is the long way
though and you are on your own for any future maintenance

[1] https://apps.fedoraproject.org/packages/lttng-tools
[2] https://apps.fedoraproject.org/packages/lttng-ust
[3]
http://www.rackspace.com/knowledge_center/article/installing-rhel-epel-repo-on-centos-5x-or-6x
[4] http://wiki.centos.org/HowTos/RebuildSRPM

Best of luck!

--
Suchakra
