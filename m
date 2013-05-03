From: Wade Farnsworth <wade_farnsworth@mentor.com>
Subject: Re: babeltrace assertion "`pos->offset
 <=	pos->content_size' failed"
Date: Fri, 3 May 2013 06:53:26 -0700
Message-ID: <5183C156.70102__24392.3468086452$1367589277$gmane$org@mentor.com>
References: <50461F57.5010401@mentor.com> <20130503131538.GA31382@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <wade_farnsworth@mentor.com>) id 1UYGQs-0006Pi-LW
	for lttng-dev@lists.lttng.org; Fri, 03 May 2013 09:53:54 -0400
In-Reply-To: <20130503131538.GA31382@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

Commit 4ef415a92af77f9324026b62e023e15824330dcd fixed the problem for
me.  Sorry for not being more explicit about this.

Regards,

Wade

Mathieu Desnoyers wrote:
> Are you still experiencing this issue ?
> =

> Thanks,
> =

> Mathieu
> =

> * Wade Farnsworth (wade_farnsworth@mentor.com) wrote:
>> Hi,
>>
>> I'm occasionally seeing the following error when I pass a trace through  =

>> babeltrace:
>>
>> babeltrace: ../../include/babeltrace/ctf/types.h:203: ctf_pos_get_event:=
  =

>> Assertion `pos->offset <=3D pos->content_size' failed.
>> Aborted
>>
>> Here are my platform details:
>>
>> Board: ARM Pandaboard
>> Kernel: v3.1.0 from  =

>> git://dev.omapzoom.org/pub/scm/integration/kernel-ubuntu.git
>> lttng-modules: v2.0.5
>> lttng-tools: v2.0.3
>> babeltrace: 1.0.0-rc5
>>
>> Now, I'm not very familiar with the internal workings of, but it seems  =

>> like this situation should be prevented by the call to v_cmpxchg in  =

>> lib_ring_buffer_check_deliver() which claims to have exclusive subbuffer=
  =

>> access when the content_size field is written.  Is this understanding  =

>> correct?
>>
>> Does anyone have any suggestions on where the problem might be?  Any  =

>> help you might be able to give me would be appreciated.
>>
>> Thanks,
>>
>> Wade Farnsworth
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =



-- =

Wade Farnsworth | Sr. Embedded Linux Dev. Engr.
Mentor Embedded=99
Nucleus=AE | Linux=AE | Android=99 | Services | UI | Multi-OS
Android is a trademark of Google Inc. Use of this trademark is subject
to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and
other countries
