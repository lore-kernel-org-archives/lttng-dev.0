From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Extracting System Call IDs By Using TMF
Date: Mon, 2 Dec 2013 16:10:09 -0500
Message-ID: <529CF731.4020901__42038.9841929593$1386018724$gmane$org@ericsson.com>
References: <CAKQh6phjqskTkP5OfG3-NN9UBhWxK6UtiyZA+YcoG=x7aYS=yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1Vnalo-0001Mz-EJ
	for lttng-dev@lists.lttng.org; Mon, 02 Dec 2013 16:11:13 -0500
In-Reply-To: <CAKQh6phjqskTkP5OfG3-NN9UBhWxK6UtiyZA+YcoG=x7aYS=yg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


On 13-11-30 08:23 PM, Shariyar wrote:
> Hi Matthew:
>
> In that case I need to create a map myself.
>
> I  was looking for the system call ids for the following reasons:
>
> 1. In LTTng 1.0, there were several occasions when only the system call id
> was found in a trace but not the names. If such is the case with LTTng 2.0,
> then my concern is  that it would be better to extract ids.
>
> 2. Trained models need to be stored in database and ids will take lesser
> sapce as the model grows with time.
Please be careful with this, someone who knows the kernel better than me
can confirm or deny, but I believe different architectures have
different syscall ids. That means sys_recv can be 291 on arm and 102 on
mips.

So am I hearing Neural Network with this? Looking forward to seeing some
results, positive or negative. :)
>
> Regards,
> Shariyar
>
>
>
> Message: 1
> Date: Fri, 29 Nov 2013 10:39:54 -0500
> From: Matthew Khouzam <matthew.khouzam@ericsson.com>
> To: <lttng-dev@lists.lttng.org>
> Subject: Re: [lttng-dev] Extracting System Call IDs By Using TMF
> Message-ID: <5298B54A.5080907@ericsson.com>
> Content-Type: text/plain; charset="ISO-8859-1"
>
> Hi Shariyar,
>
> I would like to know what is the need for the syscall id? I looked at
> kernel events, and they store the system call name, not the id? Is it
> for performance reasons, or is there some functionality that can be
> achieved from a call ID that cannot from a name?
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
