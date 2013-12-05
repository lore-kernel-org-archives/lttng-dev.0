From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: RFC LTTng session and daemon configuration save and
	restore
Date: Thu, 5 Dec 2013 12:45:46 -0500
Message-ID: <CA+jJMxuuSBAPdorcrYqa8bYp74Sm017T9Sa+MEJ7uxMV-jC-bQ__2432.52524310282$1386265608$gmane$org@mail.gmail.com>
References: <CA+jJMxv-mg_Lx1DdZHq7LyETNmULZ=MMKUoHqMhc5t3o9BJRkg@mail.gmail.com>
	<52A0B401.8020202@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Voczo-0000vr-0y
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 12:45:58 -0500
Received: by mail-qc0-f170.google.com with SMTP id x13so3940932qcv.1
	for <lttng-dev@lists.lttng.org>; Thu, 05 Dec 2013 09:45:46 -0800 (PST)
In-Reply-To: <52A0B401.8020202@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Dec 5, 2013 at 12:12 PM, Julien Desfossez
<jdesfossez@efficios.com> wrote:
> Hi,
>
> [...]
>
>>
>> LTTng Command Line - Daemon Configuration
>> -----------------------------------------
>>
>> On launch, the session, relay and consumer daemons will search for files=
 with
>> the .conf extension in the following folders, in order of precedence:
>> 1) Any path specified using a new --load-config option
> Why "load" ?
> Why not --config (like openvpn for example) ?
> -c or -f would be also good for short options.
>

--config, -c looks good to me.

>> 2) $HOME/.lttng/*.conf
>> 3) /etc/lttng/*.conf
>>
>>
>> Session Configuration File Format
>> ---------------------------------
>>
>> The LTTng session configuration file format must enable the serializatio=
n of the
>> session, channel and event structures of the LTTng API. Since these conc=
epts
>> are eminently hierarchical, it only makes sense to use a file format tha=
t can
>> express such relationships.
>>
>> While an INI based file format was the first considered, for its ease of=
 use
>> and human readability, it appears that INI provides no standard way of
>> expressing hierarchies. It is, of course, possible to flatten session/ch=
annel
>> hierarchies using prefixed section names, but this is both error prone a=
nd
>> unsupported by most INI file reading libraries. This means that we would=
 have
>> to code our own INI handling code and produce a specification to documen=
t our
>> additions to the INI format. INI also provides no standard versioning me=
chanism.
>>
>> In keeping with the desire to use a human-readable format, we have consi=
dered
>> rolling our own format. This format could express hierarchy using tabula=
tions
>> to delimit scopes, not unlike the Python language. Such a format would b=
e both
>> relatively easy to parse, but also readable. However, this both requires
>> documenting the format in a specification, rolling our own parsing and
>> validation code, thus losing the benefit of reusing external libraries. =
This
>> option has the highest maintenance cost considering the amount of code a=
nd
>> documentation to be produced while presenting marginal benefits over the=
 INI
>> approach.
> Also, we will have fun with debugging the tab vs space issues.

Indeed. I included this part to stir the pot a bit. Rolling your own
format is always an option, albeit rarely the best...

>
>>
>> Finally, it seems that using a standard hierarchical format such as JSON=
 or
>> XML would be the most appropriate choice. Both of these formats have int=
rinsic
>> support for representation of hierarchical relationships. They also bene=
fit from
>> having a lot of hardened external libraries that will provide parsing,
>> validation and write support. This is a huge advantage from both
>> maintainability and interoperability standpoints. However, both formats
>> present the disadvantage of being harder, although minimally, to edit ma=
nually.
>> It remains to be seen if manual editing of session configurations really=
 is an
>> important use-case. Using lttng's save feature would probably prove more
>> convenient than editing the files manually. Furthermore, the addition of=
 a
>> "dry-run" option to the lttng client would significantly alleviate this =
pain
>> point.
>>
>> XML seems like a better option than JSON since it makes it possible to h=
ave
>> robust file validation using a pre-defined schema. The use of version-sp=
ecific
>> schemas could also be beneficial for backward compatibility as the format
>> moves forward. Finally, character encoding handling is already a solved
>> problem for most XML libraries.
>>
>>
>> LTTng ABI/API
>> -------------
>>
>> Two new functions are added to the lttng.h API.
>>
>> int lttng_load_sessions(const char *url, const char *session_name,
>> int flags/struct lttng_session_load_attr *attr);
>>
>> Load sessions. If url the is a directory, all .lttng files it contains w=
ill be
>> loaded. If session_name is NULL, all sessions found in url are restored.
>> If a session_name is provided, only this session will be restored.
>>
>> A supplementary argument, either a "flags" argument or an attribute stru=
cture,
>> is used to indicate whether or not the sessions currently known to the
>> session daemon should be replaced by the ones found in the configuration
>> file(s), provided that their names are the same.
>> Even though this is the only current use-case for this argument, a struc=
ture
>> with a reasonable amount of padding may be more suitable than a primary
>> type to accommodate new features. Thoughts?
> Would it be possible instead, to have an enum and a len field, to avoid
> padding issues ?

Good question. I'm curious to hear what David has to say about that one.

>
>>
>>
>> int lttng_save_sessions(const char *url, const char *session_name
>> int flags/struct lttng_session_save_attr *attr);
>>
>> Save sessions. If url is a directory, the session configuration will be =
saved
>> as session_name.lttng. If a complete file name is provided, the session(=
s) to be
>> saved will be written to this file. If session_name is NULL, all sessions
>> currently known to the session daemon will be saved. If a name is provid=
ed, only
>> that session will be saved.
>>
>> The reasoning for the flags/attr argument is the same as for the
>> lttng_load_sessions() function, but for a configuration file overwrite
>> option.
>>
> In save and load, can the URL be a network URL (like the net:// we have) ?
> I can easily see a use-case for that in the future, where we would have
> a repository of session configurations. Especially in cloud/large-scale
> deployments.
> I don't think we should rush into implementing that, but having the
> interface easy to extend would be interesting.
>

Support for this use-case is not planned right now, but that's
certainly in the cards. This will be a very powerful feature.

>>
>> LTTng Command Line - Session Configuration
>> ------------------------------------------
>>
>> Tracing session configurations can be saved and restored using the lttng=
 command
>> line client. This capability introduces two new command line options.
>>
>>
>> -- Load session configurations --
>>
>> $ lttng load -s SESSION_NAME [OPTIONS]
>>
>> Loads tracing session configurations.
>>
>> .lttng files will be searched in the following default paths, in order of
>> precedence:
>> 1) $(HOME)/.lttng/sessions
>> 2) /etc/lttng/sessions
>>
>> A session name or the -a option must be passed as the SESSION_NAME argum=
ent.
>> Like some other lttng commands, such as enable-event, the -a option stan=
ds for
>> "all". If this option is used, every session found in the paths will be =
loaded.
>>
>> If a session was saved as active, the tracing for that session will be a=
ctivated
>> automatically on load. The current session configuration of the session =
daemon
>> is also preserved when a configuration is loaded. The new session config=
urations
>> are added to the current session set.
>>
>> Tracing sessions saved in an active state will be resumed on load.
>>
>> --input-path, -i
>> Path in which to search for SESSION_NAME's description. If the path is a
>> directory, all .lttng files it contains will be opened and searched for
>> SESSION_NAME. If an input path is provided, the -a option will load all
>> session configurations found in this path. The default paths are ignored=
 when
>> this option is used.
> Can we have multiple paths separated by ":" (like $PATH) ?
> Also, if we have a configuration path already specified in the sessiond
> configuration file, will we override or merge the search paths with -i ?
>
--input-path overrides everything. Support for multiple paths is a good ide=
a.

>>
>> --force, -f
>> If a restored session's name conflicts with a currently existing session=
, the
>> original session configuration is preserved. However, if the --force opt=
ion is
>> used, the restored session takes precedence. The original session will be
>> destroyed.
>>
>>
>> -- Save session configurations --
>>
>> $ lttng save -s SESSION_NAME [OPTIONS]
>>
>> Saves tracing configurations.
>>
>> The selected tracing session's configuration will be saved in the
>> $HOME/.lttng/sessions folder. If the -a option is used, every session kn=
own
>> to the session daemon will be saved.
> I wonder if we will have trouble with saving only the sessions of our
> user (if a root sessiond is running). I think -a will save everything
> regardless of the user. Not sure if it is a problem, but we could maybe
> specify a uid as well if we want to save all the sessions of a
> particular user ?
>

I suppose a --user option would make sense when the user is root or
part of the tracing group.

>>
>> --output-path, -o
>> If the provided output path is a directory, the session will be saved in=
 a
>> file named "SESSION_NAME.lttng". However, if the path is a file, the ses=
sion(s)
>> will all be saved in the same file.
>>
>>
>
> It looks good !
>
> I can't wait to have that for lttngtop ;-) !

Can't wait to try that ;)

J=E9r=E9mie

>
> Thanks,
>
> Julien



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
