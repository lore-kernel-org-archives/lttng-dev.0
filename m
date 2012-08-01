From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [lttng-tools PATCH] lttng-tools python module
Date: Wed, 1 Aug 2012 11:13:27 -0400
Message-ID: <CAGDH53mt0N1BiqL3opx8Mh6rkS78ndzAnak7G742xQVeur-YGw__19359.1138151989$1343834044$gmane$org@mail.gmail.com>
References: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>
	<50182739.3030604@polymtl.ca> <50182FEF.6070504@gmail.com>
	<501936F6.7010800@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lpp01m010-f48.google.com ([209.85.215.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1SwacA-0000eh-Aa
	for lttng-dev@lists.lttng.org; Wed, 01 Aug 2012 11:13:34 -0400
Received: by lagz14 with SMTP id z14so5328094lag.35
	for <lttng-dev@lists.lttng.org>; Wed, 01 Aug 2012 08:13:27 -0700 (PDT)
In-Reply-To: <501936F6.7010800@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <david.goulet@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

> - From my point of view, I'm not sure it is, for now, a good idea since it adds
> a considerable amount work to fully support (at least on my side) a library
> that is an extra functionality and for that I see this in extras/ for now.

+1 for extras.
I suggest extras/bindings/swig/python. The Apache Subversion project has
a similar tree [1].

Christian

[1] - http://svn.apache.org/repos/asf/subversion/trunk/subversion/bindings/swig/
