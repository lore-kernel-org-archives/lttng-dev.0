From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Subject: Re: Working on some bugs
Date: Tue, 11 Mar 2014 23:59:57 -0700
Message-ID: <CAEEAEzX3KOz0JDGGee20f2CBtFuPhrRUX2m2hzhut5WObGVBuw__36315.7132560902$1394607700$gmane$org@mail.gmail.com>
References: <CAEEAEzWcPk788kF=BptjeGsG=hrWyeK1tcUAM4Fq9GAwZYPXhQ@mail.gmail.com>
	<20140311162201.GE7727@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <babbusandy2006@gmail.com>) id 1WNd91-000407-AC
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 03:00:05 -0400
Received: by mail-qg0-f48.google.com with SMTP id j107so27947082qga.7
	for <lttng-dev@lists.lttng.org>; Tue, 11 Mar 2014 23:59:57 -0700 (PDT)
In-Reply-To: <20140311162201.GE7727@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

>> http://bugs.lttng.org/issues/621
>
> This one should be quite straight forward. There is already version
> check for the create_session command I think. Here is your starting
> point.
>
   I don't see the version check in create_session in create.c or
session_create in session.c. Though I can see that in function
relay_send_version in main.c, there is check for the major version (at
line 1432).

         if (reply.major != be32toh(msg.major)) {

Is this what you meant? Please let me know. Thanks !

> lttng-tools:
> * src/bin/lttng-relayd/cmd-*
> * src/bin/lttng-relayd/main.c
