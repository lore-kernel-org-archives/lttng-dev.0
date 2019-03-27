From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Creating custom application
Date: Wed, 27 Mar 2019 13:52:51 -0400
Message-ID: <20190327175251.GA7976__20239.1856744484$1553709195$gmane$org@joraj-alpa>
References: <CAJyWpKHE_4eZwMAhU-q4sbAAA3-nPWgxtGqpXYLpMyztNzmm-w@mail.gmail.com>
 <20190326152942.GE17481@joraj-alpa>
 <CAJyWpKHtXHAgyjwZVnSCnnDTmCsOVsydaZgqpMuALQWMy5nfiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44TwZc5Q7Jz182F
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2019 13:52:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAJyWpKHtXHAgyjwZVnSCnnDTmCsOVsydaZgqpMuALQWMy5nfiA@mail.gmail.com>
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

On Wed, Mar 27, 2019 at 12:09:54PM -0400, Mosleh Uddin wrote:
> Hello,
> 
> Thank you for the quick response. I was able to use the documentation you
> provided to start a session and get tracepoint list. I do have some
> follow-up questions:
> 
> 1) I needed to create a session daemon before executing my custom
> application. In the API I did see functionality to see if a daemon is
> active, however, it is possible to spawn a session daemon in my custom app?

liblttng-ctl does not expose a lttng-sessiond spawning function since by
definition it is a daemon executable (think apache,mysql etc.), you will have to
use system/popen/exec.. to spawn the lttng-sessiond process etc. if you want to
control its lifetime using your custom application.

> 
> 2) I am able to get a list of active traces lttng can see in userspace, I
> enable all the traces and start tracing. The traces however seem to not be
> written anywhere on my filesystem. Do I have to specify a location? Or am I
> missing something? My current flow is:

Please refer to the create command. If outputting locally you will need to pass
a "file://...." url to lttng_create_session.

You can check on the result for each steps using "lttng list" and "lttng list
<session_name>" as you go to troubleshot your setup script.

While debugging you can also start the lttng-sessiond in verbose mode to
understand what is going on.

Also note that you could also use the lttng "load" api if the session you are
trying to load is "static" and always the same. You would only need to ship an
xml file with your application.

Cheers

> 
>    - Creating a session
>    - Specifying the domain
>    - Creating a handle
>    - Creating a channel (with default attributes)
>    - Enabling the channel
>    - Enabling event (for all traces)
>    - Start tracing
> 
> Thanks again for all the assistance.
> 
> Regards,
> Mosleh
> 
> On Tue, Mar 26, 2019 at 11:29 AM Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
> 
