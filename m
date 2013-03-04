From: David Goulet <dgoulet@efficios.com>
Subject: Re: Changes in the lttng-tools cause issues in build
Date: Mon, 04 Mar 2013 12:06:22 -0500
Message-ID: <5134D48E.1020406__34607.3390137919$1362416829$gmane$org@efficios.com>
References: <CAHg4Oy-xKD6zHbQrATEQ9oQQoO-wUf7f-CriT0NbTr-CHGr=uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UCYq5-0003Ei-An
	for lttng-dev@lists.lttng.org; Mon, 04 Mar 2013 12:06:13 -0500
In-Reply-To: <CAHg4Oy-xKD6zHbQrATEQ9oQQoO-wUf7f-CriT0NbTr-CHGr=uA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Balboul <amit.balboul@shinesec.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Amit,

Have you tried to bootstrap the repository again with a make distclean ?

Second thing, this "header_type" is an enum from LTTng-UST and you
should make sure that you have the HEAD of master to build with the
master of tools.

Let me know if you solved the issue.

Thanks!
David

Amit Balboul:
> Hi all,
> 
> I recently pulled the updated sources from the lttng-tools repository,
> having the latest *commit e58727c84472f69d641d94efaf90e728cda84a6b.*
> *
> *
> When I tried to re-build it I'm having some issues in compilation.
> (I'm building for Android but those issues are not related to it).
> Some I managed to workaroud, but some, like for example
> 
> ust-registry.h:70: error: field 'header_type' has incomplete type
> 
> are just an enigma. I assume this is not some configuration issue since
> grep-ing ustctl_channel_header in the source doesn't result any useful
> match (just some uses of it).
> 
> Am I missing something here?
> 
> Amit.
> 
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
