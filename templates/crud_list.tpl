<h1>{@jelix~crud.title.list@}</h1>

{if $list->rowCount()}

    <table class="records-list">
    <thead>
    <tr>
        {foreach $properties as $propname}
        {if isset($controls[$propname])}
        <th>{$controls[$propname]->label|eschtml}</th>
        {else}
        <th>{$propname|eschtml}</th>
        {/if}
        {/foreach}
        <th>&nbsp;</th>
    </tr>
    </thead>
    <tbody>
    {foreach $list as $record}
    <tr class="{cycle array('odd','even')}">
        {foreach $properties as $propname}
            {if isset($controls[$propname]) && $controls[$propname]->type == 'checkbox'}
                <td class="centered">
                    {if $record->$propname}
                        <img src="{$j_basepath}jediAdmin/images/tick.png" alt="1"/>
                    {else}
                        <img src="{$j_basepath}jediAdmin/images/cross.png" alt="0"/>
                    {/if}
                </td>
            {else}
                <td>{$record->$propname|eschtml}</td>
            {/if}
        {/foreach}
        <td>
            {foreach $actions as $action}
                {if $action == 'edit'}
                    <a href="{jurl $editAction, array('id'=>$record->$primarykey, $offsetParameterName=>$page)}" class="crud-link icon-edit">{@jelix~crud.link.edit.record@}</a>
                {elseif $action == 'view'}
                    <a href="{jurl $viewAction,array('id'=>$record->$primarykey, $offsetParameterName=>$page)}" class="crud-link icon-view">{@jelix~crud.link.view.record@}</a>
                {elseif $action == 'delete'}
                    <a href="{jurl $deleteAction, array('id'=>$record->$primarykey, $offsetParameterName=>$page)}" class="crud-link icon-delete" onclick="return confirm('{@jelix~crud.confirm.deletion@}')">{@jelix~crud.link.delete.record@}</a>
                {/if}
            {/foreach}
        </td>
    </tr>
    {/foreach}
    </tbody>
    </table>
    {if $recordCount > $listPageSize}
    <p class="record-pages-list">{@jelix~crud.title.pages@} : {pagelinks $listAction, array(),  $recordCount, $page, $listPageSize, $offsetParameterName }</p>
    {/if}

    {if in_array('create', $actions)}
        <p><a href="{jurl $createAction}" class="crud-link icon-create">{@jelix~crud.link.create.record@}</a></p>
    {/if}

{else}
    {@jediAdmin~main.list.no.results@}
{/if}

{if $filter_form}
    {form $filter_form, '#'}
        <table class="jforms-table filter">
            {formcontrols}
                <tr>
                    <th>{ctrl_label}</th>
                    <td>{ctrl_control} </td>
                </tr>
            {/formcontrols}
        </table>
        <div>{formsubmit} <a href="{jurl '#', array('_reset' => 1)}">{@jediAdmin~main.form.filter.reset@}</a></div>
    {/form}
{/if}