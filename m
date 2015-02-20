From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: adding new channel
Date: Fri, 20 Feb 2015 14:20:19 -0500
Message-ID: <54E788F3.5040704__37360.2983578623$1424460089$gmane$org@voxpopuli.im>
References: <CAM5kDqydAEebJm0_MotZ0xTAMJo51j+Zxxw5-skppaJYcN6g0Q@mail.gmail.com>
 <CAB4xu_3QRDuKefYVY4Bc_eTs5tnmaYDb4+Um1Rf3t2zYtZO1jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1YOt7i-0003Xd-B7
 for lttng-dev@lists.lttng.org; Fri, 20 Feb 2015 14:20:27 -0500
In-Reply-To: <CAB4xu_3QRDuKefYVY4Bc_eTs5tnmaYDb4+Um1Rf3t2zYtZO1jQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>, Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


On 02/20/2015 02:05 PM, Philippe Proulx wrote:
> On Fri, Feb 20, 2015 at 2:00 PM, Anand Neeli <anand.neeli@gmail.com> wrote:
>> Hi All,
>> Is adding a new channel to an existing(running) session supported?
> No.
>> i get following error when doing this.
>> Error: Channel myc5: Tracing already started
>>
>> Is there any way to add channels on the fly?
> No. LTTng's documentation [1] states:
>
>      Note: Because of a current limitation, all channels must be
>      created prior to beginning tracing in a given tracing session,
>      i.e. before the first time you do lttng start.

The wording "Because of a current limitation" seems to imply that it 
could and will eventually be rectified. It this actually the case, or is 
the doc just giving the user false hope? ;)


Alex

>
>      Since a channel is automatically created by enable-event
>      only for the specified domain, you cannot, for example, enable
>      a kernel domain event, start tracing and then enable a user
>      space domain event because no user space channel exists
>      yet and it's too late to create one.
>
>      For this reason, make sure to configure your channels
>      properly before starting the tracers for the first time!
>
> Phil
>
> [1] http://lttng.org/docs/#doc-enabling-disabling-channels
>
>> I'm using 2.4.1 version
>>
>> Thanks,
>> Anand Neeli
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
