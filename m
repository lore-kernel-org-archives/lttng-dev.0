From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: lttng, lttng-sessiond and the tracing group
Date: Wed, 6 Feb 2013 12:52:25 -0500
Message-ID: <CAGDH53n_ZMYQdfhD377uSR=_SjP7JLm9iLXzm=Sq+tXB8n1idQ__37842.4750910655$1360173205$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD013EB1@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1U39Ad-0006gn-B9
	for lttng-dev@lists.lttng.org; Wed, 06 Feb 2013 12:52:31 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so1898979iaz.16
	for <lttng-dev@lists.lttng.org>; Wed, 06 Feb 2013 09:52:25 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD013EB1@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,

>    First observation

I'm not able to reproduce your first observation on my machine.

> [...]
> $ sudo lttng -vvv create rootlevel
> DEBUG3: URI string: file:///home/daniel/lttng-traces/rootlevel-20130206-091954 [in uri_parse() at uri.c:253]
> DEBUG3: URI file destination: /home/daniel/lttng-traces/rootlevel-20130206-091954 [in uri_parse() at uri.c:290]
> DEBUG3: URI dtype: 3, proto: 0, host: , subdir: , ctrl: 0, data: 0 [in uri_parse() at uri.c:467]
> DEBUG1: LSM cmd type : 8 [in send_session_msg() at lttng-ctl.c:261]
> Session rootlevel created.
> Traces will be written in /home/daniel/lttng-traces/rootlevel-20130206-091954
> DEBUG1: Init config session in /home/daniel [in config_init() at conf.c:294]

This looks wrong. Traces should be written under the
/root/lttng-traces. Are you sure this command has effectively been
issued has the root user? It looks like it was issued as your normal
user hence the "session=rootlevel" in your user ~/.lttngrc. Could you
try su'ing to root instead?

>    Second observation
>
>    Contention for ~/.lttngrc can lead to odd behaviour.  This can only occur with users in the tracing group, I think (the root lttng-sessiond has no business writing to a non-tracing user's home directory).  Witness this:

I'm also not able to reproduce this situation. I'm thinking there
might be a slight difference between the sudo and $HOME directory
behavior between our two machines...

>    Third observation
>
>    'lttng set-session' issues an error only if there is no name specified or if the name is too long (or if .lttngrc is root-owned, of course): it'll happily change the contents to whatever the argument is, including non-existent sessions or even illegal session names (containing embedded '/', for example).

Yes this is the expected behavior. From the lttng man-page:

"
set-session NAME
       Set current session name
       Will change the session name in the .lttngrc file.
"

Verification is done when issuing the "start" command. An invalid or
non-existent session will be detected and no tracing will occur.

>A too-long session name (246 characters or more) also has the unfortunate side effect of wiping the contents of .lttngrc.

Could you file a bug report for this issue here:
http://bugs.lttng.org/projects/lttng-tools

Thanks,

Christian
