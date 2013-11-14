From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 7/7] Add a check against excluders
Date: Thu, 14 Nov 2013 14:25:17 +0000 (UTC)
Message-ID: <692188761.67141.1384439117906.JavaMail.zimbra__45425.1558556736$1384439193$gmane$org@efficios.com>
References: <1383819755-6891-1-git-send-email-jp_ikaheimonen@mentor.com>
	<1383819755-6891-8-git-send-email-jp_ikaheimonen@mentor.com>
	<682132616.66259.1384351513959.JavaMail.zimbra@efficios.com>
	<009B25148989C6458484484699278506E539FA81@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VgxrE-0003Sc-Sb
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 09:25:26 -0500
In-Reply-To: <009B25148989C6458484484699278506E539FA81@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Not needed, I already fixed it.

Thanks,

Mathieu

----- Original Message -----
> From: "JP Ikaheimonen" <jp_ikaheimonen@mentor.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Thursday, November 14, 2013 2:26:33 AM
> Subject: RE: [lttng-dev] [PATCH lttng-ust 7/7] Add a check against excluders
> 
> Thank you Mathieu!
> I will make these changes and resubmit this one patch.
> 
> Cheers,
> JP
> 
> -----Original Message-----
> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> Sent: 13. marraskuuta 2013 16:05
> To: Ikaheimonen, JP
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] [PATCH lttng-ust 7/7] Add a check against excluders
> 
> ----- Original Message -----
> > From: "JP Ikaheimonen" <jp_ikaheimonen@mentor.com>
> > To: lttng-dev@lists.lttng.org
> > Sent: Thursday, November 7, 2013 5:22:35 AM
> > Subject: [lttng-dev] [PATCH lttng-ust 7/7] Add a check against
> > excluders
> > 
> > When matching enablers with events, first check against all excluders
> > of the enabler. If the event matches with any of the excluders, then
> > the event does not match with the enabler.
> > 
> > Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
> > ---
> >  liblttng-ust/lttng-events.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
> > index 915cffb..fa5596c 100644
> > --- a/liblttng-ust/lttng-events.c
> > +++ b/liblttng-ust/lttng-events.c
> > @@ -491,6 +491,29 @@ static
> >  int lttng_desc_match_enabler(const struct lttng_event_desc *desc,
> >  		struct lttng_enabler *enabler)
> >  {
> > +	struct lttng_ust_excluder_node *excluder;
> > +
> > +	/* If event matches with an excluder, return 'does not match' */
> > +	cds_list_for_each_entry(excluder, &enabler->excluder_head, node) {
> > +		int found = 0;
> 
> Why is "found" declared here ? Why is it initialized to 0 ?
> 
> 
> > +		int count, len;
> > +		char *excluder_name;
> > +
> > +		for (count = 0; count < excluder->excluder.count; count++) {
> 
> Rather than declared here ?
> 
> 
> > +			excluder_name = (char *)(excluder->excluder.names)
> > +					+ count * LTTNG_UST_SYM_NAME_LEN;
> > +			len = strnlen(excluder_name, LTTNG_UST_SYM_NAME_LEN);
> > +			if (len > 0 && excluder_name[len - 1] == '*') {
> > +				found = strncmp(desc->name, excluder_name, len - 1);
> 
> strncmp and "found" have reversed logic. I'd assign found = !strncmp(....).
> 
> > +			} else {
> > +				found = strncmp(desc->name, excluder_name,
> > +						LTTNG_UST_SYM_NAME_LEN - 1);
> > +			}
> > +			if (!found) {
> 
> and reverse this condition.
> 
> The other patches in this patchset look good !! Good job !!
> 
> Thanks,
> 
> Mathieu
> 
> > +				return 0;
> > +			}
> > +		}
> > +	}
> >  	switch (enabler->type) {
> >  	case LTTNG_ENABLER_WILDCARD:
> >  		return lttng_desc_match_wildcard_enabler(desc, enabler);
> > --
> > 1.8.1.2
> > 
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
