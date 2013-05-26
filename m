From: Aryeh Weinreb <weinrea@gmail.com>
Subject: Re: Getting started with UST
Date: Sun, 26 May 2013 16:26:32 +0300
Message-ID: <CAE5ibEkiyYRJyC0HYDHH6OuLUeebfLkCvXt0+O-AunT6bsTgXQ__11252.9332320721$1369574837$gmane$org@mail.gmail.com>
References: <CAE5ibEneMm2D1=3Zy8hbtV42Y22TwW2rRAqimyMSfMPvtiYCiA@mail.gmail.com>
	<51A209D6.6010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <weinrea@gmail.com>) id 1Ugay5-0003LJ-Tt
	for lttng-dev@lists.lttng.org; Sun, 26 May 2013 09:26:38 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so5884009pbb.34
	for <lttng-dev@lists.lttng.org>; Sun, 26 May 2013 06:26:32 -0700 (PDT)
In-Reply-To: <51A209D6.6010802@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Sun, May 26, 2013 at 4:10 PM, Yannick Brosseau
<yannick.brosseau@gmail.com> wrote:
> Hi,
>
> Did you forgot to enable some event, for example:
> lttng enable-event -u -a
> (For all userspace events)
>

I did now, but I still can't get anything.

# lttng list my_session
Tracing session my_session: [active]
    Trace path: /root/lttng-traces/my_session-20130526-074913

=== Domain: UST global ===

Channels:
-------------
- channel0: [enabled]

    Attributes:
      overwrite mode: 0
      subbufers size: 4096
      number of subbufers: 4
      switch timer interval: 0
      read timer interval: 200
      output: mmap()

    Events:
      * (type: tracepoint) [enabled]


# ./sample

# lttng view
Trace directory: /root/lttng-traces/my_session-20130526-074913

[error] Cannot open any trace for reading.

[error] opening trace "/root/lttng-traces/my_session-20130526-074913"
for reading.

[error] none of the specified trace paths could be opened.


# ls -l /root/lttng-traces/my_session-20130526-074913
total 4
drwxrwx--- 2 root root 4096 May 26 07:49 ust

# ls -l /root/lttng-traces/my_session-20130526-074913/ust/
total 0

# lttng list -u
UST events:
-------------
None
