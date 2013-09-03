From: <Paul_Woegerer@mentor.com>
Subject: Re: How to disable an event that's been enabled by a
	wildcard selection or -a? (lttng-dev Digest, Vol 64, Issues 30, 38)
Date: Tue, 3 Sep 2013 18:55:38 +0200
Message-ID: <1986194.AcrmLPglby__31331.8934328437$1378227408$gmane$org@atv-pwoegere-l3.atv.mentorg.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2678BEB2@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VGttL-0000Of-Ba
	for lttng-dev@lists.lttng.org; Tue, 03 Sep 2013 12:55:53 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2678BEB2@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tuesday 03 September 2013 15:05:45 Thibault, Daniel wrote:
> ----------------------------------------------------------------------
> > Date: Tue, 20 Aug 2013 11:27:46 +0200
> >
> > If that is the intention, then it would be better to specify the commands 
in reverse order:
> >
> > # lttng enable-event "!ab" -u
> > # lttng enable-event "a*" -u
> >
> > or even better:
> >
> > # lttng enable-event "!ab" "a*" -u
> >
> > > However, if the event 'ab' is already registered in the session, the 
first command would enable the event 'ab'.
> > > Should the second command now disable the event 'ab', or should the 
command only apply to future registrations of events ?
> >
> > That is exactly what would happen in an *active* *session* if you issue
> > the commands in the order you originally suggested.
> > Incoming events matching "a*" are recorded up to the point where 'lttng
> > enable-event "!ab"' is executed. From then on,  'ab'-events are excluded
> > from recording.
> >
> > Paul Woegerer, SW Development Engineer
> ----------------------------------------------------------------------
> 
>    It makes little sense to me that the sequence:
> 
> # lttng enable-event "!ab" -u
> # lttng enable-event "a*" -u
> 
> should "enable all events except 'ab'"  (the original intent).  There would
> be no way of ever turning 'ab' back on, unless the command treated the wild

To reenable event 'ab' you would simply invoke:

lttng disable-event "!ab" -u

This would effectively remove the exclusion and let again any event matching 
"a*" (like 'ab') in.

> I note that the "!" special character was not used in older versions of 
enable-event, leading to limited backward compatibility of this new interface 
convention.  Is the intent to remove the disable-event command entirely?

Not at all. This is orthogonal to enable-event/disable-event.

Regarding the "!" ... we are open for suggestions here.
We would even prefer to use a character that is rejected by current versions 
of lttng (i.e. results in an error when used in "lttng enable-event", because 
this would make checking if the exclusion feature is available much easier).

Thanks,
Paul

-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
