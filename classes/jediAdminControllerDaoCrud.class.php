<?php
/**
* @package    jediAdmin
* @author     Florian Lonqueu-Brochard
* @copyright  2012 Florian Lonqueu-Brochard
* @link       http://github.com/FlorianLB/jediAdmin
* @license    MIT
*/

abstract class jediAdminControllerDaoCrud extends jControllerDaoCrud {

    /**
     * list of actions which will be displayed in the list page
     * possible values : edit, view, create, delete
     * @var array
     */
    protected $actionsForList = array('view', 'create');

    /**
     * list of actions which will be displayed in the edit page
     * possible values : view, create, delete, list
     * @var array
     */
    protected $actionsForEdit = array('list');

    /**
     * list of actions which will be displayed in the view page
     * possible values : edit, create, delete, list
     * @var array
     */
    protected $actionsForView = array('edit', 'delete', 'list');

    /**
     * the selector of the filter form
     * @var string
     */
    protected $filterForm;

    /**
     * private instance of the filter form
     * @var jFormsBase
     */
    protected $_filterForm;

    /**
     * @see jControllerDaoCrud::$listTemplate
     */
    protected $listTemplate = 'jediAdmin~crud_list';

    /**
     * @see jControllerDaoCrud::$editTemplate
     */
    protected $editTemplate = 'jediAdmin~crud_edit';

    /**
     * @see jControllerDaoCrud::$viewTemplate
     */
    protected $viewTemplate = 'jediAdmin~crud_view';

    /**
     * @see jControllerDaoCrud::_getResponse()
     */
    protected function _getResponse(){
        $rep =$this->getResponse('html');
        $basepath = jApp::config()->urlengine['basePath'];
        $rep->addCSSLink($basepath.'jediAdmin/css/jediAdmin.css');

        return $rep;
    }

    /**
     * init the filter form
     */
    protected function initFilterForm(){
        if ($this->filterForm) {
            $class = get_class($this);
            if ($this->param('_submit') && !$this->param('_reset'))
                $this->_filterForm = jForms::fill($this->filterForm,$class);
            else
                $this->_filterForm = jForms::create($this->filterForm,$class);
        }
    }

    /**
     * add conditions based on the filter form data
     */
    protected function _indexSetConditions($cond) {
        $this->initFilterForm();
        parent::_indexSetConditions($cond);

        foreach ($this->_filterForm->getControls() as $control) {
            $data = $this->_filterForm->getData($control->ref);
            if($data == '') {
                continue;
            }
            //input string
            if ($control->type == 'input' && $control->datatype instanceof jDatatypeString) {
                $cond->addCondition($control->ref, 'LIKE', '%'.$data.'%');
            }
            //checbox boolean
            elseif ($control->type =='menulist' && $control->datasource instanceof jFormsStaticDatasource) {
                $cond->addCondition($control->ref, '=', $data);
            }
        }
    }

    /**
     * @see jControllerDaoCrud::_index()
     */
    protected function _index($resp, $tpl) {
        $tpl->assign('actions' , $this->actionsForList);
        $tpl->assign('filter_form', $this->_filterForm);
    }

    /**
     * @see jControllerDaoCrud::_editUpdate()
     */
    protected function _editUpdate($form, $resp, $tpl) {
        $tpl->assign('actions' , $this->actionsForEdit);
        $tpl->assign('createAction' , $this->_getAction('create'));
        $tpl->assign('deleteAction' , $this->_getAction('delete'));
    }

    /**
     * @see jControllerDaoCrud::_view()
     */
    protected function _view($form, $resp, $tpl) {
        $tpl->assign('actions' , $this->actionsForView);
        $tpl->assign('createAction' , $this->_getAction('create'));
    }

}
