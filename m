From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: SIG33 message
Date: Tue, 16 Apr 2019 13:58:30 -0400
Message-ID: <03778ce1-f017-176a-3c5f-35fba359b5aa__7509.20718289621$1555437988$gmane$org@gydle.com>
References: <CAJyWpKFdOV6uiwWUicD5GNSSjWsD1TXjn=p45p_g6xu7F3HJbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 44kCwj6Sqlz1Kjk
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 14:06:13 -0400 (EDT)
In-Reply-To: <CAJyWpKFdOV6uiwWUicD5GNSSjWsD1TXjn=p45p_g6xu7F3HJbQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mosleh Uddin <mosleh1235@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
Cc: jomasu22@gmail.com
List-Id: lttng-dev@lists.lttng.org

Hi Mosleh,

(I just saw Mathieu's answer arrive in my inbox while I was writing this.)

First, I don't know the exact solution.


In Linux, signals are sent with the kill() function.

In the LTTng-UST source code, there are 3 signals that relate to 'Suspended: Signal: SIG33:Real-time event 33' (RT):

libringbuffer/ring_buffer_frontend.c:82:#define LTTNG_UST_RB_SIG_FLUSH		SIGRTMIN
libringbuffer/ring_buffer_frontend.c:83:#define LTTNG_UST_RB_SIG_READ		SIGRTMIN + 1
libringbuffer/ring_buffer_frontend.c:84:#define LTTNG_UST_RB_SIG_TEARDOWN	SIGRTMIN + 2

=> http://git.lttng.org/?p=lttng-ust.git;a=blob;f=libringbuffer/ring_buffer_frontend.c;h=9721df1634585f028316d13f96b184af7e99cc08;hb=HEAD#l82


On my system (Ubuntu 18.04.2 LTS with Linux 4.15.0-47-generic), SIGRTMIN = 34.

Check with 'kill -l SIGRTMIN' on your system to see if it it the same value.



In the LTTng-UST source code, there 1 this call to kill():

libringbuffer/ring_buffer_frontend.c:767:	kill(getpid(), LTTNG_UST_RB_SIG_TEARDOWN);

=> http://git.lttng.org/?p=lttng-ust.git;a=blob;f=libringbuffer/ring_buffer_frontend.c;h=9721df1634585f028316d13f96b184af7e99cc08;hb=HEAD#l767




These custom signals seem to be handled here:

libringbuffer/ring_buffer_frontend.c:660

=>  http://git.lttng.org/?p=lttng-ust.git;a=blob;f=libringbuffer/ring_buffer_frontend.c;h=9721df1634585f028316d13f96b184af7e99cc08;hb=HEAD#l660




On 2019-04-04 3:26 p.m., Mosleh Uddin wrote:
> Hello,
> 
> I am building an application which I am compiling with the 'lttng-ust' flag. When I try to debug the application using gdb, I get a 'Suspended: Signal: SIG33:Real-time event 33' message. This only happens when I compile with the 'lttng-ust' flag, if I remove it I no longer have this issue. Any insight?
> 
> Regards,
> Mosleh
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
