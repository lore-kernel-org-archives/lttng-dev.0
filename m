From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Creating custom application
Date: Tue, 26 Mar 2019 11:29:42 -0400
Message-ID: <20190326152942.GE17481__19611.3247120351$1553614210$gmane$org@joraj-alpa>
References: <CAJyWpKHE_4eZwMAhU-q4sbAAA3-nPWgxtGqpXYLpMyztNzmm-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44TFS03qKDz17Yt
 for <lttng-dev@lists.lttng.org>; Tue, 26 Mar 2019 11:29:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAJyWpKHE_4eZwMAhU-q4sbAAA3-nPWgxtGqpXYLpMyztNzmm-w@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mosleh Uddin <mosleh1235@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mosleh,

On Tue, Mar 26, 2019 at 11:11:41AM -0400, Mosleh Uddin wrote:
> Hi all,
> 
> I am working with an embedded system and for security purposes I don't
> necessarily want the user to have the ability to execute lttng commands
> (lttng-sessiond, lttng create, etc.). In order to create a session/start I
> am creating a custom application which will communicate through my
> application via a socket. This way my application only control lttng
> functionalities.
> 
> I was wondering if you guys can direct me to some documentation where I can
> understand how I can approach creating a session and implementing the
> functionalities that commands like (lttng-sessiond, lttng create and lttng
> start) provide. Thank you for any information.

Note that lttng-sessiond can be started with a specific group id for "control"
purpose that allow only users of the group to control it. From there you could
have a simple popen based custom application that run the cli client. There are
multiple ways to achieve what you are looking for.

We also expose an API/lib (liblttng-ctl) to talk to the sessiond [1].

The best documentation on how to use this API is the headers [1] and the command
line client implementation [3].

[1] https://github.com/lttng/lttng-tools/tree/master/include/lttng
[2] https://github.com/lttng/lttng-tools/tree/master/src/bin/lttng
    https://github.com/lttng/lttng-tools/tree/master/src/bin/lttng/commands

Let us know how it goes.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
