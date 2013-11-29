From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Extracting System Call IDs By Using TMF
Date: Fri, 29 Nov 2013 10:39:54 -0500
Message-ID: <5298B54A.5080907__21541.1067045808$1385739708$gmane$org@ericsson.com>
References: <CAKQh6pji+x7NV4nURCeyozMZkbJJXfAbHvLNJJ95y21CoXT-=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1VmQBW-0005PS-Ej
	for lttng-dev@lists.lttng.org; Fri, 29 Nov 2013 10:40:53 -0500
In-Reply-To: <CAKQh6pji+x7NV4nURCeyozMZkbJJXfAbHvLNJJ95y21CoXT-=Q@mail.gmail.com>
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

Hi Shariyar,

I would like to know what is the need for the syscall id? I looked at
kernel events, and they store the system call name, not the id? Is it
for performance reasons, or is there some functionality that can be
achieved from a call ID that cannot from a name?

On 13-11-28 07:29 PM, Shariyar wrote:
>
> I need information on how to extract system call ids from a kernel
> level trace by using TMF.
> For example, a sample code to iterate through a kernel trace in CTF
> format is given below.
>
> In this code, I am able to extract the system call name and its return
> value. However, from the *event.getContent()* function, I could not
> get the system call id for the corresponding system call name.
>
> Kindly let me know, how to extract the system call id? By system call
> id I mean the actual system call id assigned by Linux to a system call
> as shown on this site: http://syscalls.kernelgrok.com/
>
