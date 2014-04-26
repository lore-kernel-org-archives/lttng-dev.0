From: =?UTF-8?Q?Adrien_Verg=C3=A9?= <adrienverge@gmail.com>
Subject: Re: [PATCH lttng-ust] Fix linking failure when
	cross-compiling
Date: Sat, 26 Apr 2014 10:55:39 -0400
Message-ID: <CANsc=4VxHxKuTBcSbWwXEFPJbBBsPtA0jgzhmn7YXrQqpjHFjQ__31534.005868207$1398524193$gmane$org@mail.gmail.com>
References: <1398442344-15165-1-git-send-email-adrienverge@gmail.com>
 <1751778549.7675.1398501609681.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <adrienverge@gmail.com>) id 1We412-0006Ah-RB
 for lttng-dev@lists.lttng.org; Sat, 26 Apr 2014 10:55:45 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz11so5982429veb.19
 for <lttng-dev@lists.lttng.org>; Sat, 26 Apr 2014 07:55:39 -0700 (PDT)
In-Reply-To: <1751778549.7675.1398501609681.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

2014-04-26 4:40 GMT-04:00 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>:
> -L../../../liblttng-ust/.libs/
> into
> -L../../../liblttng-ust/.libs
> (final / removed)
>
> It should change much things overall, but is there any reason for
> this change ?

Hi,

ld already adds a final slash to the passed directory, which results
in something like:
../../../liblttng-ust/.libs//liblttng-ust.so (notice the double slash).

If this is a problem (e.g. breaks build with other linkers than ld),
the final slash can be set back, it also works.

Adrien
