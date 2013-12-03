From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: LTTV build failure in ubuntu 12.04
Date: Mon, 02 Dec 2013 23:30:32 -0800
Message-ID: <529D8898.50507__9582.75722009621$1386055892$gmane$org@gmail.com>
References: <CAFuHdY2g+6ezgRWyFPY_iPm87DTgVT-6OD4KZiQnBVThxBSBhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1VnkRb-000685-6E
	for lttng-dev@lists.lttng.org; Tue, 03 Dec 2013 02:30:55 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so19384452pdj.8
	for <lttng-dev@lists.lttng.org>; Mon, 02 Dec 2013 23:30:49 -0800 (PST)
In-Reply-To: <CAFuHdY2g+6ezgRWyFPY_iPm87DTgVT-6OD4KZiQnBVThxBSBhg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aananth CN <c.n.aananth@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

hi,

Which version of babeltrace is installed on the system?

On 11/25/13 08:52, Aananth CN wrote:
> Hi,
>
> I could not find lttv (viewer) on ubuntu, hence I built from source. I
> get following error. Could you please help me resolving this issue?
> (Am I missing something, should I install any other packages?)
>
> make all-recursive
> make[1]: Entering directory `/home/caananth/Downloads/lttv-1.5'
> Making all in lttv
> make[2]: Entering directory `/home/caananth/Downloads/lttv-1.5/lttv'
> Making all in lttv
> make[3]: Entering directory `/home/caananth/Downloads/lttv-1.5/lttv/lttv'
> CC state.o
> state.c: In function =91restore_init_state=92:
> state.c:413:25: error: =91BT_CLOCK_REAL=92 undeclared (first use in this
> function)
> state.c:413:25: note: each undeclared identifier is reported only once
> for each function it appears in
> state.c:413:9: error: too many arguments to function
> =91bt_trace_handle_get_timestamp_begin=92
> /usr/include/babeltrace/trace-handle.h:45:10: note: declared here
> state.c: In function =91state_save_after_trace_hook=92:
> state.c:3531:2: warning: #warning "Would we move max_time to traceset"
> [-Wcpp]
> make[3]: *** [state.o] Error 1
> make[3]: Leaving directory `/home/caananth/Downloads/lttv-1.5/lttv/lttv'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/home/caananth/Downloads/lttv-1.5/lttv'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/caananth/Downloads/lttv-1.5'
> make: *** [all] Error 2
>
>
